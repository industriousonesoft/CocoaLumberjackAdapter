//
//  CocoaLumberjackAdapter.m
//  CocoaLumberjackAdapter
//
//  Created by Mark Cao on 2020/6/28.
//  Copyright © 2020 iosguy. All rights reserved.
//

#import "CocoaLumberjackAdapter.h"
#import <objc/runtime.h>

const NSInteger APRLumberjackContext = (NSInteger)0xced70676;

@protocol APRLogger_DDLog

// Copied from CocoaLumberjack's DDLog interface
+ (void) log:(BOOL)asynchronous message:(NSString *)message level:(NSUInteger)level flag:(NSUInteger)flag context:(NSInteger)context file:(const char *)file function:(const char *)function line:(NSUInteger)line tag:(id)tag;

@end

static Class DDLogClass = Nil;

static void (^const CocoaLumberjackLogHandler)(NSString * (^)(void), APRLogLevel, const char *, const char *, NSUInteger) = ^(NSString *(^message)(void), APRLogLevel level, const char *file, const char *function, NSUInteger line)
{
    // The `XCDLogLevel` enum was carefully crafted to match the `DDLogFlag` options from DDLog.h
    [DDLogClass log:YES message:message() level:NSUIntegerMax flag:(1 << level) context:APRLumberjackContext file:file function:function line:line tag:nil];
};

static void (^LogHandler)(NSString * (^)(void), APRLogLevel, const char *, const char *, NSUInteger) = ^(NSString *(^message)(void), APRLogLevel level, const char *file, const char *function, NSUInteger line)
{
    char *logLevelString = getenv("APRLogLevel");
    NSUInteger logLevelMask = logLevelString ? strtoul(logLevelString, NULL, 0) : (1 << APRLogLevelError) | (1 << APRLogLevelWarning);
    if ((1 << level) & logLevelMask)
        NSLog(@"[APRLogger] %@", message());
};

@implementation APRLogger

+ (void) initialize
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        DDLogClass = objc_lookUpClass("DDLog");
        if (DDLogClass)
        {
            const SEL logSeletor = @selector(log:message:level:flag:context:file:function:line:tag:);
            const char *typeEncoding = method_getTypeEncoding((Method)class_getClassMethod(DDLogClass, logSeletor));
            const char *expectedTypeEncoding = protocol_getMethodDescription(@protocol(APRLogger_DDLog), logSeletor, /* isRequiredMethod: */ YES, /* isInstanceMethod: */ NO).types;
            if (typeEncoding && expectedTypeEncoding && strcmp(typeEncoding, expectedTypeEncoding) == 0) {
                NSLog(@"Injected CocoaLumberjackLog");
                LogHandler = CocoaLumberjackLogHandler;
            }else {
                NSLog(@"[APRLogger] Incompatible CocoaLumberjack version. Expected \"%@\", got \"%@\".", expectedTypeEncoding ? @(expectedTypeEncoding) : @"", typeEncoding ? @(typeEncoding) : @"");
            }
        }
    });
}

+ (void) setLogHandler:(void (^)(NSString * (^message)(void), APRLogLevel level, const char *file, const char *function, NSUInteger line))logHandler
{
    LogHandler = logHandler;
}

+ (void) logMessage:(NSString * (^)(void))message level:(APRLogLevel)level file:(const char *)file function:(const char *)function line:(NSUInteger)line
{
    if (LogHandler)
        LogHandler(message, level, file, function, line);
}

@end
