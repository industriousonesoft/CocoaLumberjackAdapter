//
//  CocoaLumberjackAdapter+Auxiliary.h
//  CocoaLumberjackAdapter
//
//  Created by Mark Cao on 2020/6/28.
//  Copyright © 2020 iosguy. All rights reserved.
//
#import "APRLogger.h"

#define APRLog(_level, _message) [CocoaLumberjackAdapter logMessage:(_message) level:(_level) file:__FILE__ function:__PRETTY_FUNCTION__ line:__LINE__]

#define APRLogError(format, ...)   APRLog(APRLogLevelError,   (^{ return [NSString stringWithFormat:(format), ##__VA_ARGS__]; }))
#define APRLogWarning(format, ...) APRLog(APRLogLevelWarning, (^{ return [NSString stringWithFormat:(format), ##__VA_ARGS__]; }))
#define APRLogInfo(format, ...)    APRLog(APRLogLevelInfo,    (^{ return [NSString stringWithFormat:(format), ##__VA_ARGS__]; }))
#define APRLogDebug(format, ...)   APRLog(APRLogLevelDebug,   (^{ return [NSString stringWithFormat:(format), ##__VA_ARGS__]; }))
#define APRLogVerbose(format, ...) APRLog(APRLogLevelVerbose, (^{ return [NSString stringWithFormat:(format), ##__VA_ARGS__]; }))
