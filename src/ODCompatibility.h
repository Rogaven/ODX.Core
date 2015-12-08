// ODCompatibility.h
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

// OS TARGETS
#define OD_IOS      TARGET_OS_IPHONE
#define OD_OSX      TARGET_OS_MAC
#define OD_TV       TARGET_OS_TV
#define OD_WATCH    TARGET_OS_WATCH

// OS VERSIONS
#define OD_IOS_TEST(sign, x) (NSFoundationVersionNumber sign NSFoundationVersionNumber_iOS_##x)
#define OD_OSX_TEST(sign, x) (NSFoundationVersionNumber sign NSFoundationVersionNumber##x)

// iOS
#define OD_IOS9_AVAILABLE (OD_IOS_TEST(>,  8_3))
#define OD_IOS8_AVAILABLE (OD_IOS_TEST(>=, 8_0))
#define OD_IOS7_AVAILABLE (OD_IOS_TEST(>=, 7_0))
#define OD_IOS6_AVAILABLE (OD_IOS_TEST(>=, 6_0))
#define OD_IOS5_AVAILABLE (OD_IOS_TEST(>=, 5_0))
#define OD_IOS4_AVAILABLE (OD_IOS_TEST(>=, 4_0))

#define OD_OSX10_11_AVAILABLE (OD_OSX_TEST(>,  10_10_3))
#define OD_OSX10_10_AVAILABLE (OD_OSX_TEST(>=,  10_10))
#define OD_OSX10_9_AVAILABLE  (OD_OSX_TEST(>=,  10_9))
#define OD_OSX10_8_AVAILABLE  (OD_OSX_TEST(>=,  10_8))
#define OD_OSX10_7_AVAILABLE  (OD_OSX_TEST(>=,  10_7))
#define OD_OSX10_6_AVAILABLE  (OD_OSX_TEST(>=,  10_6))


#define OD_IOS9 (OD_IOS_TEST(>, 8_3))
#define OD_IOS8 (OD_IOS_TEST(>=, 8_0) && OD_IOS_TEST(<=, 8_3))
#define OD_IOS7 (OD_IOS_TEST(>=, 7_0) && OD_IOS_TEST(<, 8_0))
#define OD_IOS6 (OD_IOS_TEST(>=, 6_0) && OD_IOS_TEST(<, 7_0))
#define OD_IOS5 (OD_IOS_TEST(>=, 5_0) && OD_IOS_TEST(<, 6_0))
#define OD_IOS4 (OD_IOS_TEST(>=, 4_0) && OD_IOS_TEST(<, 5_0))

#define OD_OSX10_11 (OD_OSX_TEST(>,  10_10_3))
#define OD_OSX10_10 (OD_OSX_TEST(>=, 10_10_0) && OD_OSX_TEST(<=, 10_10_3))
#define OD_OSX10_9  (OD_OSX_TEST(>=, 10_9_0) && OD_OSX_TEST(<, 10_10_0))
#define OD_OSX10_8  (OD_OSX_TEST(>=, 10_8_0) && OD_OSX_TEST(<, 10_9_0))
#define OD_OSX10_7  (OD_OSX_TEST(>=, 10_7_0) && OD_OSX_TEST(<, 10_8_0))
#define OD_OSX10_6  (OD_OSX_TEST(>=, 10_6_0) && OD_OSX_TEST(<, 10_7_0))

@interface ODDevice : NSObject
+ (BOOL)isIOSSimulator;

+ (BOOL)isMac;
+ (BOOL)isWatch;
+ (BOOL)isTV;
+ (BOOL)isIPhone;
+ (BOOL)isIPad;

+ (BOOL)isIPhone4x;
+ (BOOL)isIPhone5x;
+ (BOOL)isIPhone6x;
+ (BOOL)isIPhone6Px;

+ (BOOL)hasRetina;

+ (BOOL)hasCamera;
+ (BOOL)hasFrontCamera;
+ (BOOL)hasRearCamera;

+ (BOOL)hasMicrophone;
@end

@interface ODApp : NSObject
+ (NSString *)appVersion;
+ (NSString *)buildVersion;
@end