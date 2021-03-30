//
//  CocoaLumberjackAdapter+Auxiliary.h
//  CocoaLumberjackAdapter
//
//  Created by Mark Cao on 2020/6/28.
//  Copyright © 2020 iosguy. All rights reserved.
//
#import "IGYOCLogger.h"

@interface IGYOCLogger (Private)
+ (void) logMessage:(NSString * (^)(void))message level:(IGYLogLevel)level file:(const char *)file function:(const char *)function line:(NSUInteger)line;
@end

#define IGYOCLog(_level, _message) [IGYOCLogger logMessage:(_message) level:(_level) file:__FILE__ function:__PRETTY_FUNCTION__ line:__LINE__]

#define IGYOCLogError(format, ...)   IGYOCLog(IGYLogLevelError,   (^{ return [NSString stringWithFormat:(format), ##__VA_ARGS__]; }))
#define IGYOCLogWarning(format, ...) IGYOCLog(IGYLogLevelWarning, (^{ return [NSString stringWithFormat:(format), ##__VA_ARGS__]; }))
#define IGYOCLogInfo(format, ...)    IGYOCLog(IGYLogLevelInfo,    (^{ return [NSString stringWithFormat:(format), ##__VA_ARGS__]; }))
#define IGYOCLogDebug(format, ...)   IGYOCLog(IGYLogLevelDebug,   (^{ return [NSString stringWithFormat:(format), ##__VA_ARGS__]; }))
#define IGYOCLogVerbose(format, ...) IGYOCLog(IGYLogLevelVerbose, (^{ return [NSString stringWithFormat:(format), ##__VA_ARGS__]; }))

