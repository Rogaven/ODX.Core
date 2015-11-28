//
// NSObject+ODTransformation.m
//
// Copyright (c) 2009-2015 Alexey Nazaroff, AJR
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "NSObject+ODTransformation.h"

#define OD_EACH_OBJ(arr) arr enumerateObjectsUsingBlock:^(id _Nonnull obj, BOOL * _Nonnull stop)
#define OD_EACH_OBJIDX(arr) arr enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
#define OD_EACH_KEYOBJ(arr) arr enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop)

@implementation NSArray (ODTransformation)

- (BOOL)od_everyObject:(BOOL (^)(id, NSUInteger))predicate {
    if (predicate) {
        for (NSUInteger i=0; i<self.count; ++i) {
            if (!predicate(self[i], i)) {
                return NO;
            }
        }
    }
    return YES;
}

- (BOOL)od_someObject:(BOOL (^)(id, NSUInteger))predicate {
    if (predicate) {
        for (NSUInteger i=0; i<self.count; ++i) {
            if (predicate(self[i], i)) {
                return YES;
            }
        }
    }
    return NO;
}

- (NSArray *)od_filterObjects:(BOOL (^)(id, NSUInteger, BOOL *))predicate {
    if (!predicate) return nil;
    return [self objectsAtIndexes:[self indexesOfObjectsPassingTest:predicate]];
}

- (id)od_filterObject:(BOOL (^)(id, NSUInteger, BOOL *))predicate {
    if (!predicate) return nil;
    NSUInteger idx = [self indexOfObjectPassingTest:predicate];
    return idx == NSNotFound ? nil : [self objectAtIndex:idx];
}

- (NSArray *)od_mapObjects:(id (^)(id, NSUInteger))predicate {
    if (!predicate || self.count == 0) return [self copy];
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:self.count];
    [OD_EACH_OBJIDX(self){
        [arr addObject:predicate(obj, idx) ?: [NSNull null]];
    }];
    return [arr copy];
}

- (id)od_reduceObjects:(id (^)(id, id, NSUInteger))predicate {
    return [self od_reduceObjects:predicate initial:nil];
}

- (id)od_reduceObjects:(id (^)(id, id, NSUInteger))predicate initial:(id)initial {
    id val = initial;
    for (NSUInteger i=0; i<self.count; ++i) {
        val = predicate(val, self[i], i);
    }
    return val;
}

- (NSDictionary *)od_dictionaryWithMappedKeys:(id (^)(id, NSUInteger))predicate {
    return [NSDictionary dictionaryWithObjects:self forKeys:[self od_mapObjects:predicate]];
}

@end
