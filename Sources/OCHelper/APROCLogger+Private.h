//
//  CocoaLumberjackAdapter+Auxiliary.h
//  CocoaLumberjackAdapter
//
//  Created by Mark Cao on 2020/6/28.
//  Copyright © 2020 iosguy. All rights reserved.
//
#import "APROCLogger.h"

@interface APROCLogger (Private)
+ (void) logMessage:(NSString * (^)(void))message level:(APRLogLevel)level file:(const char *)file function:(const char *)function line:(NSUInteger)line;
@end

#define APROCLog(_level, _message) [APROCLogger logMessage:(_message) level:(_level) file:__FILE__ function:__PRETTY_FUNCTION__ line:__LINE__]

#define APROCLogError(format, ...)   APROCLog(APRLogLevelError,   (^{ return [NSString stringWithFormat:(format), ##__VA_ARGS__]; }))
#define APROCLogWarning(format, ...) APROCLog(APRLogLevelWarning, (^{ return [NSString stringWithFormat:(format), ##__VA_ARGS__]; }))
#define APROCLogInfo(format, ...)    APROCLog(APRLogLevelInfo,    (^{ return [NSString stringWithFormat:(format), ##__VA_ARGS__]; }))
#define APROCLogDebug(format, ...)   APROCLog(APRLogLevelDebug,   (^{ return [NSString stringWithFormat:(format), ##__VA_ARGS__]; }))
#define APROCLogVerbose(format, ...) APROCLog(APRLogLevelVerbose, (^{ return [NSString stringWithFormat:(format), ##__VA_ARGS__]; }))

