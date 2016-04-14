//
//  NSString+ODUtils.m
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

#import "NSString+ODUtils.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (ODXCore_Hash)

- (NSString *)od_md5 {
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];

    CC_MD5(cStr, (CC_LONG) strlen(cStr), result);

    return [NSString
            stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                             result[0], result[1],
                             result[2], result[3],
                             result[4], result[5],
                             result[6], result[7],
                             result[8], result[9],
                             result[10], result[11],
                             result[12], result[13],
                             result[14], result[15]
    ];
}

@end

@implementation NSString (ODXCore_Substrings)

- (BOOL)od_hasSubstring:(NSString *)substring {
    return [self rangeOfString:substring].location != NSNotFound;
}

- (NSString *)od_firstLetter {
    return (self.length > 0) ? [NSString stringWithFormat:@"%C", [self characterAtIndex:0]] : @"";
}

- (NSString *)od_firstLetterCapitalizedString {
    if (self.length > 0) {
        return [self stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[self substringToIndex:1] uppercaseString]];
    }

    return self;
}

@end

@implementation NSString (ODXCore_Email)

- (BOOL)od_isEmailAddress {
    NSString *regexp = @".+@.+\\..+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexp];
    return [pred evaluateWithObject:self];
}

@end


@implementation NSString (ODXCore_Random)

+ (NSString *)od_randomString {
    srand((unsigned int) time(NULL));
    return [@(rand()) stringValue];
}

@end

@implementation NSString (ODXCore_Generate)

- (NSString *)od_repeatTimes:(NSUInteger)times {
    return [@"" stringByPaddingToLength:times * [self length] withString:self startingAtIndex:0];
}

@end

@implementation NSString (ODXCore_Hex)

- (unsigned int)od_hexInteger {
    NSScanner *scanner = [NSScanner scannerWithString:self];
    unsigned int intColor = 0;
    [scanner scanHexInt:&intColor];
    return intColor;
}

@end

@implementation NSString (ODXCore_Escapes)

- (NSString *)od_stringByReplacingSQLEscapes {
    NSString *escapedString = [self stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
    return [escapedString stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
}

@end

@implementation NSString (ODXCore_Chars)

- (BOOL)od_hasNonAlphabetSymbols {
    return ([self rangeOfString:@"[^\\w]" options:NSRegularExpressionSearch].location != NSNotFound);
}

@end