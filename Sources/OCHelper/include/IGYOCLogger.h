//
//  CocoaLumberjackAdapter.h
//  CocoaLumberjackAdapter
//
//  Created by Mark Cao on 2020/6/28.
//  Copyright © 2020 iosguy. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const NSInteger IGYLumberjackContext;

/**
 *  The log levels, closely mirroring the log levels of CocoaLumberjack.
 */
typedef NS_ENUM(NSUInteger, IGYLogLevel) {
    
    IGYLogLevelError   = 0,
   
    IGYLogLevelWarning = 1,
   
    IGYLogLevelInfo    = 2,
   
    IGYLogLevelDebug   = 3,
    
    IGYLogLevelVerbose = 4,
};

NS_ASSUME_NONNULL_BEGIN

@interface IGYOCLogger : NSObject

/**
 @param logHandler The block called when a log is emitted by the XCDYouTubeKit framework. If you set the log handler to nil, logging will be completely disabled.
 
 *  - The `message` parameter is a block returning a string that you must call to evaluate the log message.
 *  - The `level` parameter is the log level of the message, see `<APRLogLevel>`.
 *  - The `file` parameter is the full path of the file, captured with the `__FILE__` macro where the log is emitted.
 *  - The `function` parameter is the function name, captured with the `__PRETTY_FUNCTION__` macro where the log is emitted.
 *  - The `line` parameter is the line number, captured with the `__LINE__` macro where the log is emitted.
 
 */
+ (void) setLogHandler:(void (^)(NSString * (^message)(void), IGYLogLevel level, const char *file, const char *function, NSUInteger line))logHandler;

+ (void)warning:(NSString *)logString;
+ (void)info:(NSString *)logString;
+ (void)error:(NSString *)logString;
+ (void)debug:(NSString *)logString;
+ (void)verbose:(NSString *)logString;

@end

NS_ASSUME_NONNULL_END
