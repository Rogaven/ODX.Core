// ODPath.h
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

#import <Foundation/Foundation.h>

NS_INLINE
NSString *ODSearchFirstPathForDirectoryInUserDomain(NSSearchPathDirectory directory) {
    return NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES).firstObject;
}

@interface ODPath: NSObject

/** Path to applications directory (Applications) */
+ (NSString *)applictions;

/** Path to library directory (Library) */
+ (NSString *)library;

/** Path to user home directories (Users) */
+ (NSString *)users;

/** Path to current user home directory (Users/usrname/) */
+ (NSString *)home;

/** Path to documentation directory (Documentation) */
+ (NSString *)documentation;

/** Path to documents directory (Documents) */
+ (NSString *)documents;

/** Path to app support directory (Library/Application Support) */
+ (NSString *)applictionSupport;

/** Path to users's desktoop directory (~/Desktop) */
+ (NSString *)desktop;

/** Path to discardable cache files directory (Library/Caches) */
+ (NSString *)caches;


/** Path to trash bin */
+ (NSString *)trash NS_AVAILABLE_MAC(10_8);

/** Path to file in resource directory */
+ (NSString *)pathToResourcesWithName:(NSString *)name;

@end