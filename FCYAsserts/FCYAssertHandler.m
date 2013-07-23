//
//  Created by Felipe Cypriano on 10/05/13.
//  Copyright (c) 2013 Felipe Cypriano. All rights reserved.
//


#import "FCYAssertHandler.h"

#ifndef FCYAssertLog
#define FCYAssertLog NSLog
#endif

#ifdef NS_BLOCK_ASSERTIONS
#define __FCYShouldAbort NO
#else
#define __FCYShouldAbort YES
#endif


NSString *const FCYAssertErrorDomain = @"FCYAssert";

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
    va_list args;
    va_start(args, format);
    [self _assertFailureShouldAbort:YES withExpression:expression function:function file:file line:line description:format arguments:args];
    va_end(args);
}

- (void)assertFailureOrReturnWithExpression:(NSString *)expression function:(NSString *)function file:(NSString *)file line:(NSInteger)line description:(NSString *)format, ... {
    va_list args;
    va_start(args, format);
    [self _assertFailureShouldAbort:__FCYShouldAbort withExpression:expression function:function file:file line:line description:format arguments:args];
    va_end(args);
}

- (void)assertFailureOrReturnBlock:(FCYAssertReturnBlock)returnBlock withExpression:(NSString *)expression function:(NSString *)function file:(NSString *)file line:(NSInteger)line description:(NSString *)format, ... {
    va_list args;
    va_start(args, format);
    NSString *logMessage = [self _assertFailureShouldAbort:__FCYShouldAbort withExpression:expression function:function file:file line:line description:format arguments:args];
    va_end(args);

    NSError *error = [NSError errorWithDomain:FCYAssertErrorDomain
                                         code:0
                                     userInfo:@{ NSLocalizedDescriptionKey : logMessage }];
    returnBlock(error);
}


#pragma mark - Private Methods

- (NSString *)_assertFailureShouldAbort:(BOOL)shouldAbort withExpression:(NSString *)expression function:(NSString *)function file:(NSString *)file line:(NSInteger)line description:(NSString *)format arguments:(va_list)args {
    NSString *description = @"";
    if (format) {
        description = [[NSString alloc] initWithFormat:format arguments:args];
    }
    FCYAssertLog(@"%@: Assertion '%@' failed on line %@:%ld. %@", function, expression, file, (long) line, description);
    if (shouldAbort) {
        abort();
    }
    return [NSString stringWithFormat:@"%@: Assertion '%@' failed on line %@:%ld. %@", function, expression, file, (long) line, description];
}

@end