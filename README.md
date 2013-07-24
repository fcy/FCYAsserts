# FCYAsserts

Inspired by [Friday Q&A 2013-05-03: Proper Use of Asserts][1] I made these macros
to handle my assertions.

**Be Aware:** I don't disable the asserts in release code. I agree with Mike Ash
that if something is wrong it should break ASAP.

## Assert or Return

Inspired by [Krzysztof Zabłocki blog post][3], macros of the family `FCYAssertOrReturn` does not
crash the app in release builds only in debug. Why this? An app shouldn't crash because of an external change.

**Important Note:** `FCYAssertOrReturn` uses `NS_BLOCK_ASSERTIONS` just like `NSAssert`.

## When Should I Use One Or The Other?

- `FCYAssert`, if you have control over the caller code;
- `FCYAssertOrReturn`, if you are asserting external code, for example, if a JSON root element is a NSDictionary.

# Installation

## Using CocoaPods

In your Podfile add this line:

`pod 'FCYAsserts'`

## Old School

Just add the files in `FCYAsserts` and import `FCYAsserts.h` in your prefix 
header (`*.pch`) or directly in each `.m` you want.

# Usage

## FCYAssert

The usage is exactly like NSAssert the difference is that the log is more complete.

```
// AppDelegate.m

#import "FCYAsserts.h"

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self startLengthyOperation];
    // ...
}

- (void)startLengthyOperation {
    FCYAssertIsNotInMainThread;
    // ...
}
```

Would abort with the following log using, by default, `NSLog`:

> -[TPAppDelegate startLengthyOperation]: Assertion '(![NSThread isMainThread])' failed on line /Users/you/dev/Project/AppDelegate.m:56. This should not be running on the main thread.

## FCYAssertOrReturn

```
NSError *error;
id json = [NSJSONSerialization JSONObjectWithData:dataFromServer options:0 error:&error];
if (error) {
    completionBlock(nil, error);
} else {
    FCYAssertOrReturnBlock([json isKindOfClass:[NSDictionary class]], @"Invalid Server Data", ^(NSError *assertError){
        completionBlock(nil, assertError);
    });

    completionBlock(json, nil);
}
```

If json is not a NSDictionary in debug code it would abort and log and in release it would just log:

> -[MyClass callServiceWithCompletionBlock:]: Assertion '[json isKindOfClass:[NSDictionary class]]' failed on line /Users/you/dev/Project/MyClass.m:42. Invalid Server Data

## Log messages with CocoaLumberjack

If you use [CocoaLumberjack][2] you can make FCYAsserts use it by defining
`FCYAssertLog`:

```
#import "FCYAsserts.h"
#define FCYAssertLog DDLogError
```

With CocoaLumberjack you can save your logs into a file, and much more. Which 
is very useful to support request, you could attach the logs when the user
send a support request from within your app.

And it is **faster** than `NSLog`.

Enjoy!

# License

(The MIT License)

Copyright © 2013 Felipe Cypriano

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
documentation files (the ‘Software’), to deal in the Software without restriction, including without limitation
the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and
to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of
the Software.

THE SOFTWARE IS PROVIDED ‘AS IS’, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO
THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


[1]: http://www.mikeash.com/pyblog/friday-qa-2013-05-03-proper-use-of-asserts.html
[2]: https://github.com/robbiehanson/CocoaLumberjack
[3]: http://www.merowing.info/2013/07/expanded-use-of-asserts/