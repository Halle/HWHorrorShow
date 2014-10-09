HWHorrorShow
============

A tiny, self-documenting, randomized cross-thread stress test as a category of XCTestCase, for use with XCTestExpectations in asynchronous testing, intended for finding unsafe sequences of messages in cases where you expect to handle any exceptions gracefully.

How to use XCTestCase+HWHorrorShow:

1. Add XCTestCase+HWHorrorShow.h and XCTestCase+HWHorrorShow.m to your project, making sure that XCTestCase+HWHorrorShow.m is added to your XCTest target.
2. add #import "XCTestCase+HWHorrorShow.h" to your test file.
3. In your XCTest that supports XCTestCase+AsynchronousTesting, do any required setup in your test and create an NSArray of NSInvocations that encapsulate methods you would like to invoke at random time intervals in random sequence, from unknown threads. It is necessary that you make sure your NSInvocations work before using them with this category, which doesn't currently do any error checking.
4. Call the category method with appropriate values:

<pre>
- (void) fuzzCrossThreadInvocationsFromArray:(NSArray *)arrayOfNSInvocations // Pass an array of (known-to-work!) NSInvocations that you'd like to test in unknown order, at unknown intervals, from unknown threads
                                 expectation:(XCTestExpectation *)expectation // The expectation you'd like to fulfill if your test doesn't cause an exception before its timeout.
                                permutations:(NSInteger)permutations // How many times you'd like to attempt to call method/timing/thread combinations overall within the timeframe (e.g. 100 means that a total of 100 attempts to call random messages will be made)
                                testDuration:(NSTimeInterval)duration; // How long the test should last.
</pre>

As an example, assuming that you have a known-working NSInvocation called invocationOne and a known-working NSInvocation called invocationTwo:

<pre>
[self fuzzCrossThreadInvocationsFromArray:@[invocationOne,invocationTwo] expectation:_expectationThatImDoingScienceAndImStillAlive permutations:100 testDuration:30];  
</pre>

This will invoke the two invocations in random sequence, at random time intervals, from unknown threads, over a period of 30 seconds, attempting to make 100 calls in that timeframe (fewer calls can be made).

The test will pass if it gets through 95% of the timeout duration without a termination. It documents the sequence and timing of all calls by printing them to the console, so if the test crashes, the NSLogging in the console will allow you to create a permanent test that replicates the crash.
