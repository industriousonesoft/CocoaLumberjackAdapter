//
//  CocoaLumberjackAdapter.m
//  CocoaLumberjackAdapter
//
//  Created by Mark Cao on 2020/6/28.
//  Copyright © 2020 iosguy. All rights reserved.
//

#import "IGYOCLogger.h"
#import "IGYOCLogger+Private.h"
#import <objc/runtime.h>

const NSInteger IGYLumberjackContext = (NSInteger)0xced70676;

@protocol IGYOCLogger_DDLog

// Copied from CocoaLumberjack's DDLog interface
+ (void) log:(BOOL)asynchronous message:(NSString *)message level:(NSUInteger)level flag:(NSUInteger)flag context:(NSInteger)context file:(const char *)file function:(const char *)function line:(NSUInteger)line tag:(id)tag;

@end

static Class DDLogClass = Nil;

static void (^const CocoaLumberjackLogHandler)(NSString * (^)(void), IGYLogLevel, const char *, const char *, NSUInteger) = ^(NSString *(^message)(void), IGYLogLevel level, const char *file, const char *function, NSUInteger line)
{
    // The `XCDLogLevel` enum was carefully crafted to match the `DDLogFlag` options from DDLog.h
    [DDLogClass log:YES message:message() level:NSUIntegerMax flag:(1 << level) context:IGYLumberjackContext file:file function:function line:line tag:nil];
};

static void (^LogHandler)(NSString * (^)(void), IGYLogLevel, const char *, const char *, NSUInteger) = ^(NSString *(^message)(void), IGYLogLevel level, const char *file, const char *function, NSUInteger line)
{
    char *logLevelString = getenv("IGYLogLevel");
    NSUInteger logLevelMask = logLevelString ? strtoul(logLevelString, NULL, 0) : (1 << IGYLogLevelError) | (1 << IGYLogLevelWarning);
    if ((1 << level) & logLevelMask)
        NSLog(@"[IGYLogger] %@", message());
};

@implementation IGYOCLogger

+ (void) initialize
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        DDLogClass = objc_lookUpClass("DDLog");
        if (DDLogClass)
        {
            const SEL logSeletor = @selector(log:message:level:flag:context:file:function:line:tag:);
            const char *typeEncoding = method_getTypeEncoding((Method)class_getClassMethod(DDLogClass, logSeletor));
            const char *expectedTypeEncoding = protocol_getMethodDescription(@protocol(IGYOCLogger_DDLog), logSeletor, /* isRequiredMethod: */ YES, /* isInstanceMethod: */ NO).types;
            if (typeEncoding && expectedTypeEncoding && strcmp(typeEncoding, expectedTypeEncoding) == 0) {
                NSLog(@"Injected CocoaLumberjackLog");
                LogHandler = CocoaLumberjackLogHandler;
            }else {
                NSLog(@"[IGYLogger] Incompatible CocoaLumberjack version. Expected \"%@\", got \"%@\".", expectedTypeEncoding ? @(expectedTypeEncoding) : @"", typeEncoding ? @(typeEncoding) : @"");
            }
        }
    });
}

+ (void) setLogHandler:(void (^)(NSString * (^message)(void), IGYLogLevel level, const char *file, const char *function, NSUInteger line))logHandler
{
    LogHandler = logHandler;
}

+ (void) logMessage:(NSString * (^)(void))message level:(IGYLogLevel)level file:(const char *)file function:(const char *)function line:(NSUInteger)line
{
    if (LogHandler)
        LogHandler(message, level, file, function, line);
}

+ (void)warning:(NSString *)logString {
    IGYOCLogWarning(@"%@", logString);
}

+ (void)info:(NSString *)logString {
    IGYOCLogInfo(@"%@", logString);
}

+ (void)error:(NSString *)logString {
    IGYOCLogError(@"%@", logString);
}

+ (void)debug:(NSString *)logString {
    IGYOCLogDebug(@"%@", logString);
}

+ (void)verbose:(NSString *)logString {
    IGYOCLogVerbose(@"%@", logString);
}

@end
