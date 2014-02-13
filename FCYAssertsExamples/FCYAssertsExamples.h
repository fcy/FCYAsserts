//
//  FCYAssertsExamples.h
//  FCYAsserts
//
//  Created by Jonah Williams on 2/13/14.
//  Copyright (c) 2014 Felipe Cypriano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FCYAssertsExamples : NSObject

- (void)assertsPreventNullFunctionPointerAnalyzerWarnings:(void (^)())block;
@end
