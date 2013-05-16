//
//  Created by Felipe Cypriano on 10/05/13.
//  Copyright (c) 2013 Felipe Cypriano. All rights reserved.
//


#import "FCYAssertHandler.h"

#ifndef FCYAssertLog
#define FCYAssertLog NSLog
#endif


@implementation FCYAssertHandler {

}

+ (FCYAssertHandler *)handler {
    static FCYAssertHandler *sharedHandler;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        sharedHandler = [[FCYAssertHandler alloc] init];
    });
    return sharedHandler;
}

- (void)assertFailureWithExpression:(NSString *)expression function:(NSString *)function file:(NSString *)file line:(NSInteger)line description:(NSString *)format, ... {
    NSString *description = @"";
    if (format) {
        va_list args;
        va_start(args, format);
        description = [[NSString alloc] initWithFormat:format arguments:args];
        va_end(args);
    }
    FCYAssertLog(@"%@: Assertion '%@' failed on line %@:%ld. %@", function, expression, file, (long)line, description);
    abort();
}

@end