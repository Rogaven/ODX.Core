//
//  ODXCore_Test.m
//  ODX.Core
//
//  Created by Alex Nazaroff on 12.01.10.
//  Copyright © 2009-2015 AJR. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ODXCore.h"

@interface ODStringify_Test : XCTestCase
@end

@implementation ODStringify_Test

- (void)testFileAndLine {
    XCTAssert([ODCurrentFileAndLine rangeOfString:@"ODXCore_Tests.m:18"].location != NSNotFound); // Don't move this line )
}

- (void)testStringify {
    int var;
    XCTAssert([ODStringify(var) isEqualToString:@"var"]);
    XCTAssert([ODStringifyClass(ODStringify_Test) isEqualToString:@"ODStringify_Test"]);
    
#define TEST_STRING var
    XCTAssert([ODStringifyUnwrap(TEST_STRING) isEqualToString:@"var"]);
    XCTAssert([ODStringifyUnsafe(TEST_STRING) isEqualToString:@"TEST_STRING"]);
    XCTAssert([ODStringify(TEST_STRING) isEqualToString:@"var"]);
}

- (void)testConcat {
    NSString *ODConcat(_, var) = @"test";
    XCTAssert([_var isEqualToString:@"test"]);
}

- (void)testIgnore {
    ODCompilerIgnorePush(-Wall)
    int x; // No 'unusing' warning here!
    ODCompilerPop
    
    ODCompilerIgnore(-Wall, int y); // No 'unusing' warning here!
}

@end

@interface NSObjectValidation_Test : XCTestCase
@end

@implementation NSObjectValidation_Test

- (void)testIsValid {
    XCTAssert([[NSObject new] od_isValidObject]);
    XCTAssert(![[NSNull null] od_isValidObject]);
    
    XCTAssert(![[NSObject new] od_isValidString]);
    XCTAssert(![[NSArray new] od_isValidString]);
    XCTAssert(![[NSNumber new] od_isValidString]);
    XCTAssert(![[NSDictionary new] od_isValidString]);
    XCTAssert(![[NSString new] od_isValidString]);
    XCTAssert(![[NSNull null] od_isValidString]);
    XCTAssert(![@"" od_isValidString]);
    XCTAssert([@"a" od_isValidString]);
    
    XCTAssert(![[NSObject new] od_isValidArray]);
    XCTAssert(![[NSArray new] od_isValidArray]);
    XCTAssert(![@[] od_isValidArray]);
    XCTAssert([@[ @"a" ] od_isValidArray]);
    XCTAssert(![[NSNumber new] od_isValidArray]);
    XCTAssert(![[NSDictionary new] od_isValidArray]);
    XCTAssert(![[NSString new] od_isValidArray]);
    XCTAssert(![[NSNull null] od_isValidArray]);

    XCTAssert(![[NSObject new] od_isValidDictionary]);
    XCTAssert(![[NSArray new] od_isValidDictionary]);
    XCTAssert(![[NSNumber new] od_isValidDictionary]);
    XCTAssert([[NSDictionary new] od_isValidDictionary]);
    XCTAssert(![[NSString new] od_isValidDictionary]);
    XCTAssert(![[NSNull null] od_isValidDictionary]);
    
    XCTAssert(![[NSObject new] od_isValidNumber]);
    XCTAssert(![[NSArray new] od_isValidNumber]);
    XCTAssert([@0 od_isValidNumber]);
    XCTAssert(![[NSDictionary new] od_isValidNumber]);
    XCTAssert(![[NSString new] od_isValidNumber]);
    XCTAssert(![[NSNull null] od_isValidNumber]);
}

- (void)testValidObject {
    XCTAssert([[NSObject new] od_validObject]);
    XCTAssert([[NSNull null] od_validObject] == nil);
    XCTAssert([@"" od_validObject]);
    XCTAssert([@0 od_validObject]);
    XCTAssert([@[] od_validObject]);
    XCTAssert([@{@"": @0} od_validObject]);
    
    XCTAssert([[NSObject new] od_validString] == nil);
    XCTAssert([[NSNull null] od_validString] == nil);
    XCTAssert([@"" od_validString]);
    XCTAssert([@0 od_validString]);
    XCTAssert([@[] od_validString] == nil);
    XCTAssert([@{@"": @0} od_validString] == nil);

    XCTAssert([[NSObject new] od_validNumber] == nil);
    XCTAssert([[NSNull null] od_validNumber] == nil);
    XCTAssert([@"0" od_validNumber]);
    XCTAssert([@0 od_validNumber]);
    XCTAssert([@[] od_validNumber] == nil);
    XCTAssert([@{@"": @0} od_validNumber] == nil);

    XCTAssert([[NSObject new] od_validArray] == nil);
    XCTAssert([[NSNull null] od_validArray] == nil);
    XCTAssert([@"0" od_validArray] == nil);
    XCTAssert([@0 od_validArray] == nil);
    XCTAssert([@[] od_validArray]);
    XCTAssert([@{@"": @0} od_validArray] == nil);
    
    XCTAssert([[NSObject new] od_validDictionary] == nil);
    XCTAssert([[NSNull null] od_validDictionary] == nil);
    XCTAssert([@"0" od_validDictionary] == nil);
    XCTAssert([@0 od_validDictionary] == nil);
    XCTAssert([@[] od_validDictionary] == nil);
    XCTAssert([@{@"": @0} od_validDictionary]);
}

@end

@interface NSObject (ODPropTest)
@property (nonatomic, strong) NSString *od_str;
@end

@implementation NSObject (ODPropTest)
@synthesizing_associatedRetainProperty(NSString *, od_str, setOd_str)
@end

@interface ODAssociatedProperty_Test : XCTestCase
@end

@implementation ODAssociatedProperty_Test

- (void)testProperty {
    XCTAssert([self respondsToSelector:@selector(od_str)]);
    self.od_str = @"Str";
    XCTAssert([self.od_str isEqualToString:@"Str"]);
}

@end

@interface ODDispatch_Test : XCTestCase
@end

@implementation ODDispatch_Test

- (void)testDispatches {
    ODDispatchAsyncInBackgroundThread(DISPATCH_QUEUE_PRIORITY_DEFAULT, ^{
        XCTAssert(![NSThread isMainThread]);
    });
    
    ODDispatchAsyncInMainThread(^{
        XCTAssert([NSThread isMainThread]);
    });
    
    ODDispatchAfterInMainThread(0.1, ^{
        XCTAssert([NSThread isMainThread]);
    });
    
    static int x = 0;
    for (int i=0; i<10; ++i) {
        ODDispatchOnce(^{
            x++;
        });
    }
    
    XCTAssert(x == 1);
}

@end

@interface ODPath_Test : XCTestCase
@end

@implementation ODPath_Test

- (void)testPaths {
    XCTAssert([[ODPath applictions] rangeOfString:@"Applications"].location != NSNotFound);
    XCTAssert([[ODPath library] rangeOfString:@"Library"].location != NSNotFound);
    XCTAssert([[ODPath users] rangeOfString:@"Users"].location != NSNotFound);
    XCTAssert([[ODPath home] rangeOfString:@"Users/"].location != NSNotFound);
    XCTAssert([[ODPath documentation] rangeOfString:@"Documentation"].location != NSNotFound);
    XCTAssert([[ODPath documents] rangeOfString:@"Documents"].location != NSNotFound);
    XCTAssert([[ODPath applictionSupport] rangeOfString:@"Application Support"].location != NSNotFound);
    XCTAssert([[ODPath desktop] rangeOfString:@"Desktop"].location != NSNotFound);
    XCTAssert([[ODPath caches] rangeOfString:@"Caches"].location != NSNotFound);
}

@end