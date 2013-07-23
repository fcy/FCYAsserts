//
//  Created by Felipe Cypriano on 10/05/13.
//  Copyright (c) 2013 Felipe Cypriano. All rights reserved.
//


#import <Foundation/Foundation.h>

typedef void(^FCYAssertReturnBlock)(NSError *);

extern NSString *const FCYAssertErrorDomain;


@interface FCYAssertHandler : NSObject

+ (FCYAssertHandler *)handler;

- (void)assertFailureWithExpression:(NSString *)expression
                           function:(NSString *)function
                               file:(NSString *)file
                               line:(NSInteger)line
                        description:(NSString *)format, ... NS_FORMAT_FUNCTION(5, 6);

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
                       description:(NSString *)format, ... NS_FORMAT_FUNCTION(6, 7);

@end