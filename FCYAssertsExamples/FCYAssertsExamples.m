//
//  FCYAssertsExamples.m
//  FCYAsserts
//
//  Created by Jonah Williams on 2/13/14.
//  Copyright (c) 2014 Felipe Cypriano. All rights reserved.
//

#import "FCYAssertsExamples.h"
#import "FCYAsserts.h"

@implementation FCYAssertsExamples

- (void)assertsPreventNullFunctionPointerAnalyzerWarnings:(void (^)())block {
    FCYAssertParameterNotNil(block);
    block();
}

@end
