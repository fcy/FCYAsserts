//
//  Created by Felipe Cypriano on 05/10/13.
//  Copyright (c) 2013 Felipe Cypriano. All rights reserved.
//

#import "FCYAssertHandler.h"

#define FCYAssert(condition, desc, ...) \
    do { \
        if (!(condition)) { \
            [[FCYAssertHandler handler] assertFailureWithExpression:[NSString stringWithUTF8String:#condition] \
                                               function:[NSString stringWithUTF8String:__PRETTY_FUNCTION__] \
                                                   file:[NSString stringWithUTF8String:__FILE__] \
                                                   line:__LINE__ \
                                            description:(desc), ##__VA_ARGS__]; \
        } \
    } while(0)

#define FCYAssertParameterNotNil(paramName) FCYAssert((paramName), @"Invalid parameter '%s'. Must not be nil.", #paramName)

#define FCYAssertIsInMainThread FCYAssert(([NSThread isMainThread]), @"This should be running on the main thread.")
#define FCYAssertIsNotInMainThread FCYAssert((![NSThread isMainThread]), @"This should not be running on the main thread.")

