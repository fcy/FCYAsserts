//
//  Created by Felipe Cypriano on 05/10/13.
//  Copyright (c) 2013 Felipe Cypriano. All rights reserved.
//

#import "FCYAssertHandler.h"

/// ---------------
/// @name FCYAssert
/// ---------------

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


/// -----------------------
/// @name FCYAssertOrReturn
/// -----------------------

#define FCYAssertOrReturn(condition, desc, ...) \
    do { if (!(condition)) { \
        [[FCYAssertHandler handler] assertFailureOrReturnWithExpression:[NSString stringWithUTF8String:#condition] \
                                           function:[NSString stringWithUTF8String:__PRETTY_FUNCTION__] \
                                               file:[NSString stringWithUTF8String:__FILE__] \
                                               line:__LINE__ \
                                        description:(desc), ##__VA_ARGS__]; \
        return; \
    } } while(0)

#define FCYAssertOrReturnNil(condition, desc, ...) \
    do { if (!(condition)) { \
        [[FCYAssertHandler handler] assertFailureOrReturnWithExpression:[NSString stringWithUTF8String:#condition] \
                                           function:[NSString stringWithUTF8String:__PRETTY_FUNCTION__] \
                                               file:[NSString stringWithUTF8String:__FILE__] \
                                               line:__LINE__ \
                                        description:(desc), ##__VA_ARGS__]; \
        return nil; \
    } } while(0)

#define FCYAssertOrReturnBlock(condition, desc, block) \
    do { if (!(condition)) { \
        [[FCYAssertHandler handler] assertFailureOrReturnBlock:(block) \
                withExpression:[NSString stringWithUTF8String:#condition] \
                      function:[NSString stringWithUTF8String:__PRETTY_FUNCTION__] \
                          file:[NSString stringWithUTF8String:__FILE__] \
                          line:__LINE__ \
                   description:(desc)]; \
        return; \
    } } while(0)

#define FCYAssertOrReturnNilBlock(condition, desc, block) \
    do { if (!(condition)) { \
        [[FCYAssertHandler handler] assertFailureOrReturnBlock:(block) \
                withExpression:[NSString stringWithUTF8String:#condition] \
                      function:[NSString stringWithUTF8String:__PRETTY_FUNCTION__] \
                          file:[NSString stringWithUTF8String:__FILE__] \
                          line:__LINE__ \
                   description:(desc)]; \
        return nil; \
    } } while(0)
