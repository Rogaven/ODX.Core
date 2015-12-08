// ODCompatibility.m
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

#import "ODCompatibility.h"

#if OD_IOS == 1 || OD_TV == 1
    #import <UIKit/UIKit.h>
#elif OD_OSX == 1
    #import <AppKit/AppKit.h>
#elif OD_WATCH == 1
    #import <WatchKit/WatchKit.h>
#endif

@implementation ODDevice

+ (BOOL)isIOSSimulator {
    return NO;
}

+ (BOOL)deviceIsMac {
    return NO;
}

+ (BOOL)deviceIsWatch {
    return NO;
}

+ (BOOL)deviceIsTV {
    return NO;
}

+ (BOOL)deviceIsIPhone {
    return NO;
}

+ (BOOL)deviceIsIPad {
    return NO;
//    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}

+ (BOOL)deviceIsIPhone4x {
    return NO;
}

+ (BOOL)deviceIsIPhone5x {
    return NO;
}

+ (BOOL)deviceIsIPhone6x {
    return NO;
}

+ (BOOL)deviceIsIPhone6Px {
    return NO;
}

+ (BOOL)deviceHasRetina {
    static BOOL retina = NO;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        retina = ([[UIScreen mainScreen] scale] >= 2.0);
//    });
    return retina;
}

+ (BOOL)deviceHasCamera {
    return NO;
}

+ (BOOL)deviceHasFrontCamera {
    return NO;
}

+ (BOOL)deviceHasRearCamera {
    return NO;
}

+ (BOOL)deviceHasMicrophone {
    return NO;
}

@end

//
//+ (BOOL)isRetina {

//}
//
//+ (BOOL)isSimulator {
//#if TARGET_IPHONE_SIMULATOR
//    return YES;
//#else
//    return NO;
//#endif
//}
//
//+ (BOOL)isIPad {
//
//}
//
//
//+ (BOOL)isIPhone2x {
//    return ODScreenSize.height < 568.0;
//}
//
//+ (BOOL)isIPhone5x {
//    return ODScreenSize.height == 568.0;
//}
//
//+ (BOOL)isIPhone6x {
//    return ODScreenSize.height == 667.0;
//}
//
//+ (BOOL)isIPhone6Px {
//    return ODScreenSize.height == 736.0;
//}

@implementation ODApp
static NSString * const kCFBundleShortVersionString = @"CFBundleShortVersionString";

+ (NSString *)appVersion {
    return [[NSBundle mainBundle] infoDictionary][kCFBundleShortVersionString];
}

+ (NSString *)buildVersion {
    return [[NSBundle mainBundle] infoDictionary][(__bridge NSString *) kCFBundleVersionKey];
}

@end