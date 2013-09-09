#import "Kiwi.h"
#import "FCYAsserts.h"

@interface FCYAssertHandler ()
@property (nonatomic) BOOL shouldRaiseWhenConditionFail;
@end

SPEC_BEGIN(FCYAssertsSpec)

describe(@"FCYAsserts", ^{
    context(@"FCYAssert", ^{
        it(@"raises FCYAssertException when the condition is false", ^{
            NSString *expectedDescription = @"Assertion '1 == 2' failed. Obvious false condition indeed";
            [[theBlock(^{
                FCYAssert(1 == 2, @"Obvious false condition %@", @"indeed");
            }) should] raiseWithName:FCYAssertExceptionName reason:expectedDescription];
        });

        it(@"does not raise when the condition is true", ^{
            [[theBlock(^{
                FCYAssert(1 == 1, @"Obvious true");
            }) shouldNot] raise];
        });
    });

    context(@"NS_BLOCK_ASSERTIONS is defined", ^{
        beforeAll(^{
            [FCYAssertHandler handler].shouldRaiseWhenConditionFail = NO;
        });

        describe(@"FCYAssertOrReturn", ^{
            it(@"never raises", ^{
                [[theBlock(^{
                    FCYAssertOrReturn(2 == 1, @"Not even in this case");
                    [@"Should not get here. FCYAssertOrReturn must return before" shouldBeNil];
                }) shouldNot] raise];
            });
        });

        describe(@"FCYAssertOrReturnBlock", ^{
            it(@"never raises and calls the block", ^{
                [[theBlock(^{
                    FCYAssertOrReturnBlock(3 == 8, @"Yep again", ^(NSError *error){
                        [[error should] beKindOfClass:[NSError class]];
                    });
                    [@"Should not get here. FCYAssertOrReturn must return before" shouldBeNil];
                }) shouldNot] raise];
            });
        });
    });

    context(@"NS_BLOCK_ASSERTIONS is undefined", ^{
        beforeAll(^{
            [FCYAssertHandler handler].shouldRaiseWhenConditionFail = YES;
        });

        describe(@"FCYAssertOrReturn", ^{
            it(@"raises when condition is false", ^{
                [[theBlock(^{
                    FCYAssertOrReturn(2 == 1, @"Obivous false");
                    [@"Should not get here. FCYAssertOrReturn must return before" shouldBeNil];
                }) should] raiseWithName:FCYAssertExceptionName];
            });
        });

        describe(@"FCYAssertOrReturnBlock", ^{
            it(@"raises when condition is false and calls the block", ^{
                [[theBlock(^{
                    FCYAssertOrReturnBlock(3 == 8, @"Yep again", ^(NSError *error){});
                    [@"Should not get here. FCYAssertOrReturn must return before" shouldBeNil];
                }) should] raiseWithName:FCYAssertExceptionName];
            });
        });
    });
});

SPEC_END