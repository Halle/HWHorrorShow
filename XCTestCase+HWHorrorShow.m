//
//  XCTestCase+HWHorrorShow.m
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

#import "XCTestCase+HWHorrorShow.h"

@implementation XCTestCase (HWHorrorShow)

- (void) fuzzCrossThreadInvocationsFromArray:(NSArray *)arrayOfNSInvocations expectation:(XCTestExpectation *)expectation permutations:(NSInteger)permutations testDuration:(NSTimeInterval)duration {
    
    NSTimeInterval stillAlive = duration * .95; // If we are still alive a bit before the expectation timeout hits, that is a pass.
    NSInteger minimumSeconds = 0;
    NSInteger maximumSeconds = (NSInteger)(duration * .5); // Let's use half of the overall duration as the max seconds that can pass. This could be a different value.
    
    if(maximumSeconds <= minimumSeconds) {
        maximumSeconds = minimumSeconds + 1; // Maximum, be larger than the minimum.
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:stillAlive];
        [expectation fulfill];  // Pass if we're still alive a little bit before timeout. 
    });
    
    NSLog(@"To remove timestamps in order to use a created test, remove this regex pattern from the following and replace the invocation indices with your actual method: 20[0-9][0-9]-.*?]\n\n------------------------ Test documentation follows ------------------------");
    
    for (NSInteger i = 0; i < permutations; i++) {
        
        NSTimeInterval seconds = (((float)arc4random() / 0x100000000) * (maximumSeconds - minimumSeconds) + minimumSeconds); // A random float for the NSTimeInterval.
        
        NSInteger arrayIndex = arc4random_uniform((u_int32_t)[arrayOfNSInvocations count]); // A random integer for calling random NSInvocations out of the array.
        
        // Print the block and thread sleep and which NSInvocation was called out of the array so a failing test can be reconstructed as a permanent test.
        
        
        
        NSLog(@"\n\n// Invocation number %ld\ndispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{\n\t[NSThread sleepForTimeInterval:%f];\n\t######### Replace this line with the invocation at index %zd of your invocation array #########\n});\n\n", (long)i, seconds, arrayIndex);        
        
        if(i == permutations - 1)NSLog(@"------------------------ End of test documentation ------------------------"); // Note the last round.  
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ // Do the actual async call now.
            [NSThread sleepForTimeInterval:seconds]; // Sleep for the random NSTimeInterval
            NSLog(@"Dispatching invocation %ld", (long)i);
            [[arrayOfNSInvocations objectAtIndex:arrayIndex] invoke]; // Invoke a random invocation from the array.
            
        });
    }
    
    [self waitForExpectationsWithTimeout:duration
                                 handler:^(NSError *error) {
                                     if (error != nil) {
                                         XCTFail(@"timeout error: %@", error);
                                     }                                     
                                 }];
}

@end