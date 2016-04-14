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

@interface NSObject (ODXCore_PropTest)
@property (nonatomic, strong) NSString *od_str;
@end

@implementation NSObject (ODXCore_PropTest)
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

@interface NSArrayTransformation_Test : XCTestCase
@end

@implementation NSArrayTransformation_Test

- (void)testEvery {
    XCTAssert([(@[ @0, @1, @2 ]) od_everyObject:^BOOL(NSNumber *obj, NSUInteger idx) {
        return obj.intValue >= 0;
    }]);
    
    XCTAssert(![(@[ @0, @1, @2 ]) od_everyObject:^BOOL(NSNumber *obj, NSUInteger idx) {
        return obj.intValue > 0;
    }]);
    
    XCTAssert( [@[ @1 ] od_everyObject:nil] == YES );
    XCTAssert( [@[] od_everyObject:^BOOL(id obj, NSUInteger idx) {
        return YES;
    }] == YES );
}

- (void)testSome {
    XCTAssert([(@[ @0, @1, @2 ]) od_someObject:^BOOL(NSNumber *obj, NSUInteger idx) {
        return obj.intValue > 0;
    }]);
    
    XCTAssert(![(@[ @0, @1, @2 ]) od_someObject:^BOOL(NSNumber *obj, NSUInteger idx) {
        return obj.intValue < 0;
    }]);
    
    XCTAssert( [@[ @1 ] od_someObject:nil] == NO );
    XCTAssert( [@[] od_someObject:^BOOL(id obj, NSUInteger idx) {
        return YES;
    }] == NO );
}

- (void)testFilterObject {
    XCTAssert([[(@[ @0, @1, @2 ]) od_filterObject:^BOOL(NSNumber *obj, NSUInteger idx, BOOL *stop) {
        return obj.intValue > 1;
    }] intValue] == 2);
    
    XCTAssert([(@[ @0, @1, @2 ]) od_filterObject:^BOOL(NSNumber *obj, NSUInteger idx, BOOL *stop) {
        return obj.intValue > 2;
    }] == nil);
    
    XCTAssert([(@[]) od_filterObject:^BOOL(NSNumber *obj, NSUInteger idx, BOOL *stop) {
        return obj.intValue > 2;
    }] == nil);
    XCTAssert([@[@1] od_filterObject:nil] == nil);
}

- (void)testFilterObjects {
    XCTAssert([[(@[ @0, @1, @2 ]) od_filterObjects:^BOOL(NSNumber *obj, NSUInteger idx, BOOL *stop) {
        return obj.intValue > 1;
    }] count] == 1);
  
    XCTAssert([(@[ @0, @1, @2 ]) od_filterObjects:^BOOL(NSNumber *obj, NSUInteger idx, BOOL *stop) {
        return obj.intValue > 2;
    }].count == 0);
    
    XCTAssert([@[@1] od_filterObjects:nil] == nil);
    XCTAssert([@[] od_filterObjects:^BOOL(NSNumber *obj, NSUInteger idx, BOOL *stop) { return YES; }].count == 0);
}

- (void)testMap {
    XCTAssert([[(@[ @0, @1, @2 ]) od_mapObjects:^id(id obj, NSUInteger idx) {
        return [obj stringValue];
    }] isEqualToArray:(@[ @"0", @"1", @"2" ])]);
    
    XCTAssert([[(@[ @0, @1, @2 ]) od_mapObjects:^id(id obj, NSUInteger idx) {
        return nil;
    }] isEqualToArray:(@[ [NSNull null], [NSNull null], [NSNull null] ])]);
    
    XCTAssert([[@[@1] od_mapObjects:nil] isEqualToArray:@[ @1 ]]);
    XCTAssert([@[] od_mapObjects:^id(id obj, NSUInteger idx) { return @"a"; }].count == 0);
}

- (void)testReduce {
    XCTAssert([[(@[ @0, @1, @2 ]) od_reduceObjects:^id(NSNumber *value, NSNumber *obj, NSUInteger idx) {
        return @( value.integerValue + obj.integerValue );
    }] integerValue] == 3);
    
    XCTAssert([[(@[ @0, @1, @2 ]) od_reduceObjects:^id(NSNumber *value, NSNumber *obj, NSUInteger idx) {
        return @( value.integerValue + obj.integerValue );
    } initial:@1] integerValue] == 4);
    
    XCTAssert([(@[ @0, @1]) od_reduceObjects:nil] == nil);
    XCTAssert([(@[]) od_reduceObjects:^id(NSNumber *value, NSNumber *obj, NSUInteger idx) {
        return @( value.integerValue + obj.integerValue );
    }] == nil);
}

- (void)testMapDict {
    XCTAssert([[(@[ @0, @1]) od_dictionaryWithMappedKeys:^id(id obj, NSUInteger idx) {
        return [[obj stringValue] stringByAppendingString:@"_"];
    }] isEqualToDictionary:(@{ @"0_": @0, @"1_": @1 })]);
    
    XCTAssert([[(@[ @0 ]) od_dictionaryWithMappedKeys:nil] isEqualToDictionary:(@{ @0: @0})]);
    XCTAssert([[(@[]) od_dictionaryWithMappedKeys:^id(id obj, NSUInteger idx) {
        return [[obj stringValue] stringByAppendingString:@"_"];
    }] isEqualToDictionary:(@{})]);
    
    XCTAssert([[(@[ @0, @1]) od_dictionaryWithMappedKeys:^id(id obj, NSUInteger idx) {
        return nil;
    }] isEqualToDictionary:(@{ [NSNull null]: @0 })]);
}

@end


@interface NSSetTransformation_Test : XCTestCase
@end

@implementation NSSetTransformation_Test

- (void)testEvery {    
    XCTAssert([([NSSet setWithObjects:@0, @1, @2, nil]) od_everyObject:^BOOL(NSNumber *obj) {
        return obj.intValue >= 0;
    }]);
    
    XCTAssert(![([NSSet setWithObjects: @0, @1, @2, nil]) od_everyObject:^BOOL(NSNumber *obj) {
        return obj.intValue > 0;
    }]);
    
    XCTAssert( [([NSSet setWithObjects: @1, nil]) od_everyObject:nil] == YES );
    XCTAssert( [[NSSet set] od_everyObject:^BOOL(id obj) {
        return YES;
    }] == YES );
}

- (void)testSome {
    XCTAssert([([NSSet setWithObjects: @0, @1, @2, nil]) od_someObject:^BOOL(NSNumber *obj) {
        return obj.intValue > 0;
    }]);
    
    XCTAssert(![([NSSet setWithObjects: @0, @1, @2, nil]) od_someObject:^BOOL(NSNumber *obj) {
        return obj.intValue < 0;
    }]);
    
    XCTAssert( [([NSSet setWithObjects: @1, nil]) od_someObject:nil] == NO );
    XCTAssert( [[NSSet set] od_someObject:^BOOL(id obj) {
        return YES;
    }] == NO );
}

- (void)testFilterObject {
    XCTAssert([[([NSSet setWithObjects: @0, @1, @2, nil]) od_filterObject:^BOOL(NSNumber *obj, BOOL *stop) {
        return obj.intValue > 1;
    }] intValue] == 2);
    
    XCTAssert([([NSSet setWithObjects: @0, @1, @2, nil]) od_filterObject:^BOOL(NSNumber *obj, BOOL *stop) {
        return obj.intValue > 2;
    }] == nil);
    
    XCTAssert([([NSSet set]) od_filterObject:^BOOL(NSNumber *obj, BOOL *stop) {
        return obj.intValue > 2;
    }] == nil);
    
    XCTAssert([([NSSet setWithObjects:@1, nil]) od_filterObject:nil] == nil);
}

- (void)testFilterObjects {
    XCTAssert([[([NSSet setWithObjects: @0, @1, @2, nil]) od_filterObjects:^BOOL(NSNumber *obj, BOOL *stop) {
        return obj.intValue > 1;
    }] count] == 1);
    
    XCTAssert([([NSSet setWithObjects: @0, @1, @2, nil ]) od_filterObjects:^BOOL(NSNumber *obj, BOOL *stop) {
        return obj.intValue > 2;
    }].count == 0);
    
    XCTAssert([([NSSet setWithObjects:@1, nil]) od_filterObjects:nil] == nil);
    XCTAssert([[NSSet set] od_filterObjects:^BOOL(NSNumber *obj, BOOL *stop) { return YES; }].count == 0);
}

- (void)testMap {
    XCTAssert([[([NSSet setWithObjects: @0, @1, @2, nil ]) od_mapObjects:^id(id obj) {
        return [obj stringValue];
    }] isEqualToSet:([NSSet setWithObjects: @"0", @"1", @"2", nil])]);
    
    XCTAssert([[([NSSet setWithObjects: @0, @1, @2, nil]) od_mapObjects:^id(id obj) {
        return nil;
    }] isEqualToSet:([NSSet setWithObjects: [NSNull null], [NSNull null], [NSNull null], nil])]);
    
    XCTAssert([[([NSSet setWithObjects:@1, nil]) od_mapObjects:nil] isEqualToSet:([NSSet setWithObjects: @1, nil])]);
    XCTAssert([[NSSet set] od_mapObjects:^id(id obj) { return @"a"; }].count == 0);
}

- (void)testReduce {
    XCTAssert([[([NSSet setWithObjects: @0, @1, @2 , nil]) od_reduceObjects:^id(NSNumber *value, NSNumber *obj) {
        return @( value.integerValue + obj.integerValue );
    }] integerValue] == 3);
    
    XCTAssert([[([NSSet setWithObjects: @0, @1, @2, nil ]) od_reduceObjects:^id(NSNumber *value, NSNumber *obj) {
        return @( value.integerValue + obj.integerValue );
    } initial:@1] integerValue] == 4);
    
    XCTAssert([([NSSet setWithObjects: @0, @1, nil]) od_reduceObjects:nil] == nil);
    XCTAssert([([NSSet set]) od_reduceObjects:^id(NSNumber *value, NSNumber *obj) {
        return @( value.integerValue + obj.integerValue );
    }] == nil);
}

@end


@interface NSDictionaryTransformation_Test : XCTestCase
@end

@implementation NSDictionaryTransformation_Test

- (void)testEvery {
    XCTAssert([(@{@0: @0, @1: @1, @2: @2}) od_everyObject:^BOOL(NSNumber *key, NSNumber *obj) {
        return obj.intValue >= 0;
    }]);
    
    XCTAssert(![(@{@0: @0, @1: @1, @2: @2}) od_everyObject:^BOOL(NSNumber *key, NSNumber *obj) {
        return obj.intValue > 0;
    }]);
    
    XCTAssert( [(@{@1: @1}) od_everyObject:nil] == YES );
    XCTAssert( [@{} od_everyObject:^BOOL(id key, id obj) {
        return YES;
    }] == YES );
}

- (void)testSome {
    XCTAssert([(@{@0: @0, @1: @1, @2: @2}) od_someObject:^BOOL(NSNumber *key, NSNumber *obj) {
        return obj.intValue > 0;
    }]);
    
    XCTAssert(![(@{@0: @0, @1: @1, @2: @2}) od_someObject:^BOOL(NSNumber *key, NSNumber *obj) {
        return obj.intValue < 0;
    }]);
    
    XCTAssert( [(@{@1: @1}) od_someObject:nil] == NO );
    XCTAssert( [@{} od_someObject:^BOOL(id key, id obj) {
        return YES;
    }] == NO );
}

- (void)testFilterObject {
    XCTAssert([[(@{@0: @0, @1: @1, @2: @2}) od_filterObject:^BOOL(NSNumber *key, NSNumber *obj, BOOL *stop) {
        return obj.intValue > 1;
    }] intValue] == 2);
    
    XCTAssert([(@{@0: @0, @1: @1, @2: @2}) od_filterObject:^BOOL(NSNumber *key, NSNumber *obj, BOOL *stop) {
        return obj.intValue > 2;
    }] == nil);
    
    XCTAssert([(@{}) od_filterObject:^BOOL(NSNumber *key, NSNumber *obj, BOOL *stop) {
        return obj.intValue > 2;
    }] == nil);
    
    XCTAssert([(@{@1: @1}) od_filterObject:nil] == nil);
}

- (void)testFilterObjects {
    XCTAssert([[(@{@0: @0, @1: @1, @2: @2}) od_filterObjects:^BOOL(NSNumber *key, NSNumber *obj, BOOL *stop) {
        return obj.intValue > 1;
    }] count] == 1);
    
    XCTAssert([(@{@0: @0, @1: @1, @2: @2}) od_filterObjects:^BOOL(NSNumber *key, NSNumber *obj, BOOL *stop) {
        return obj.intValue > 2;
    }].count == 0);
    
    XCTAssert([(@{@1: @1}) od_filterObjects:nil] == nil);
    XCTAssert([@{} od_filterObjects:^BOOL(NSNumber *key, NSNumber *obj, BOOL *stop) { return YES; }].count == 0);
}

- (void)testMap {
    XCTAssert([[(@{@0: @0, @1: @1, @2: @2}) od_mapObjects:^id(id key, id obj) {
        return [obj stringValue];
    }] isEqualToDictionary:(@{@0:@"0", @1:@"1", @2:@"2"})]);
    
    XCTAssert([[(@{@0:@0, @1:@1, @2:@2}) od_mapObjects:^id(id key, id obj) {
        return nil;
    }] isEqualToDictionary:(@{@0:[NSNull null], @1:[NSNull null], @2:[NSNull null]})]);
    
    XCTAssert([[(@{@1:@1}) od_mapObjects:nil] isEqualToDictionary:(@{@1:@1})]);
    XCTAssert([@{} od_mapObjects:^id(id key, id obj) { return @"a"; }].count == 0);


    XCTAssert([[(@{@0: @0, @1: @1, @2: @2}) od_mapKeys:^id(id key, id obj) {
        return [obj stringValue];
    }] isEqualToDictionary:(@{@"0": @0, @"1":@1, @"2":@2})]);
    
    XCTAssert([(@{@0:@0, @1:@1, @2:@2}) od_mapKeys:^id(id key, id obj) {
        return nil;
    }].count == 1 );
    
    XCTAssert([[(@{@1:@1}) od_mapKeys:nil] isEqualToDictionary:(@{@1:@1})]);
    XCTAssert([@{} od_mapKeys:^id(id key, id obj) { return @"a"; }].count == 0);
}

- (void)testReduce {
    XCTAssert([[(@{@0: @0, @1: @1, @2: @2 }) od_reduceObjects:^id(NSNumber *value, NSNumber *key, NSNumber *obj) {
        return @( value.integerValue + obj.integerValue );
    }] integerValue] == 3);
    
    XCTAssert([[(@{@0: @0, @1: @1, @2: @2}) od_reduceObjects:^id(NSNumber *value, NSNumber *key, NSNumber *obj) {
        return @( value.integerValue + obj.integerValue );
    } initial:@1] integerValue] == 4);
    
    XCTAssert([(@{@0: @0, @1: @1}) od_reduceObjects:nil] == nil);
    XCTAssert([(@{}) od_reduceObjects:^id(NSNumber *key, NSNumber *value, NSNumber *obj) {
        return @( value.integerValue + obj.integerValue );
    }] == nil);
}

@end