//
//  XCTestCase+HWHorrorShow.h
//
//  Created by Halle Winkler on 10/9/14.
//  Licensed under the MIT License (MIT)
//
//  Copyright (c) 2014 Halle Winkler
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import <XCTest/XCTest.h>

@interface XCTestCase (HWHorrorShow) 

/**
 
 A category of XCTextCase meant to be used with the XCTestExpectation asynchronous testing method 
 for sending randomized messages at randomized intervals from unknown threads, and documenting the 
 sequence used so that in the event that a crash is found, so you can use the sequence as a permanent test.
 
 */

- (void) fuzzCrossThreadInvocationsFromArray:(NSArray *)arrayOfNSInvocations // Pass an array of (known-to-work!) NSInvocations that you'd like to test in unknown order, at unknown intervals, from unknown threads
                                 expectation:(XCTestExpectation *)expectation // The expectation you'd like to fulfill if your test doesn't cause an exception before its timeout.
                                permutations:(NSInteger)permutations // How many times you'd like to attempt to call method/timing/thread combinations overall within the timeframe (e.g. 100 means that a total of 100 attempts to call random messages will be made)
                                testDuration:(NSTimeInterval)duration; // How long the test should last.

@end
