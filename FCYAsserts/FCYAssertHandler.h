//
//  Created by Felipe Cypriano on 10/05/13.
//  Copyright (c) 2013 Felipe Cypriano. All rights reserved.
//


#import <Foundation/Foundation.h>

typedef void(^FCYAssertReturnBlock)(NSError *);

extern NSString *const FCYAssertErrorDomain;
extern NSString *const FCYAssertExceptionName;

@interface FCYAssertHandler : NSObject

+ (FCYAssertHandler *)handler;

- (void)assertFailureWithExpression:(NSString *)expression
                           function:(NSString *)function
                               file:(NSString *)file
                               line:(NSInteger)line
                        description:(NSString *)format, ... NS_FORMAT_FUNCTION(5, 6) __attribute__((analyzer_noreturn));

- (void)assertFailureOrReturnWithExpression:(NSString *)expression
                                   function:(NSString *)function
                                       file:(NSString *)file
                                       line:(NSInteger)line
                                description:(NSString *)format, ... NS_FORMAT_FUNCTION(5, 6);

- (void)assertFailureOrReturnBlock:(FCYAssertReturnBlock)returnBlock
                    withExpression:(NSString *)expression
                          function:(NSString *)function
                              file:(NSString *)file
                              line:(NSInteger)line
                       description:(NSString *)description;

@end