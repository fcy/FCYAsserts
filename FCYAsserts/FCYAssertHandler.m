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
NSString *const FCYAssertExceptionName = @"FCYAssertException";

@interface FCYAssertHandler ()
@property (nonatomic) BOOL shouldRaiseWhenConditionFail;
@end

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

- (id)init {
    self = [super init];
    if (self) {
        self.shouldRaiseWhenConditionFail = __FCYShouldAbort;
    }
    return self;
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
    [self _assertFailureShouldAbort:self.shouldRaiseWhenConditionFail withExpression:expression function:function file:file line:line description:format arguments:args];
    va_end(args);
}

- (void)assertFailureOrReturnBlock:(FCYAssertReturnBlock)returnBlock withExpression:(NSString *)expression function:(NSString *)function file:(NSString *)file line:(NSInteger)line description:(NSString *)description {
    [self _assertFailureShouldAbort:self.shouldRaiseWhenConditionFail withExpression:expression function:function file:file line:line description:description arguments:NULL];

    NSError *error = [NSError errorWithDomain:FCYAssertErrorDomain
                                         code:0
                                     userInfo:@{ NSLocalizedDescriptionKey : description }];
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
        NSString *reason = [NSString stringWithFormat:@"Assertion '%@' failed. %@", expression, description];
        [[NSException exceptionWithName:FCYAssertExceptionName reason:reason userInfo:nil] raise];
    }
    return [NSString stringWithFormat:@"%@: Assertion '%@' failed on line %@:%ld. %@", function, expression, file, (long) line, description];
}

@end