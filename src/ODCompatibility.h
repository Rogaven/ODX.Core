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
#import "ODStringify.h"

// OS Versions
#define OD_IOS_TEST(sign, x) (NSFoundationVersionNumber sign NSFoundationVersionNumber_iOS_##x)

#define OD_IOS9_AVAILABLE (OD_IOS_TEST(>, 8_3))
#define OD_IOS8_AVAILABLE (OD_IOS_TEST(>=, 8_0))
#define OD_IOS7_AVAILABLE (OD_IOS_TEST(>=, 7_0))
#define OD_IOS6_AVAILABLE (OD_IOS_TEST(>=, 6_0))
#define OD_IOS5_AVAILABLE (OD_IOS_TEST(>=, 5_0))
#define OD_IOS4_AVAILABLE (OD_IOS_TEST(>=, 4_0))

#define OD_IOS9 (OD_IOS_TEST(>, 8_3))
#define OD_IOS8 (OD_IOS_TEST(>=, 8_0) && OD_IOS_TEST(<=, 8_3))
#define OD_IOS7 (OD_IOS_TEST(>=, 7_0) && OD_IOS_TEST(<, 8_0))
#define OD_IOS6 (OD_IOS_TEST(>=, 6_0) && OD_IOS_TEST(<, 7_0))
#define OD_IOS5 (OD_IOS_TEST(>=, 5_0) && OD_IOS_TEST(<, 6_0))
#define OD_IOS4 (OD_IOS_TEST(>=, 4_0) && OD_IOS_TEST(<, 5_0))

//@interface ODCompatibility : NSObject
//+ (NSString *)appVersion;
//+ (NSString *)buildVersion;
//
//+ (BOOL)isSimulator;
//
//+ (BOOL)isIPad;
//+ (BOOL)isIPhone2x;
//+ (BOOL)isIPhone5x;
//+ (BOOL)isIPhone6x;
//+ (BOOL)isIPhone6Px;
//+ (BOOL)isIOS6x;
//+ (BOOL)isIOS7x;
//+ (BOOL)isIOS8x;
//
//+ (BOOL)isRetina;
//@end