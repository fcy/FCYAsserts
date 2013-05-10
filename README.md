# FCYAsserts

Inspired by [Friday Q&A 2013-05-03: Proper Use of Asserts][1] I made these macros
to handle my assertions.

Be aware: I don't disable the asserts in release code. I agree with Mike Ash
that if something is wrong it should break ASAP.

# Installation

In your Podfile add this line:

`pod 'FCYAsserts'`

# Usage

The usage is exactly like NSAssert the difference is that the log is more complete.

```
#import "FCYAsserts.h"
int main(int argc, char *argv[]) {
	@autoreleasepool {
		FCYAssert(1 > 2, @"This is just a silly example %@", @"or not");
	}
}
```

Would abort with the following log using, by default, `NSLog`:

> Asserting failure: '1 > 2' in 'int main(int, char **)' on line Untitled.m:4. This is just a silly example or not

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

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the ‘Software’), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED ‘AS IS’, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


[1]: http://www.mikeash.com/pyblog/friday-qa-2013-05-03-proper-use-of-asserts.html
[2]: https://github.com/robbiehanson/CocoaLumberjack