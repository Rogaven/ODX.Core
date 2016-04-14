//
//  NSString+ODUtils.h
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

@interface NSString (ODXCore_Hash)
- (NSString *)od_md5;
@end

@interface NSString (ODXCore_Substrings)
- (BOOL)od_hasSubstring:(NSString *)substring;
- (NSString *)od_firstLetter;
- (NSString *)od_firstLetterCapitalizedString;
@end

@interface NSString (ODXCore_Email)
- (BOOL)od_isEmailAddress;
@end

@interface NSString (ODXCore_Random)
+ (NSString *)od_randomString;
@end

@interface NSString (ODXCore_Generate)
- (NSString *)od_repeatTimes:(NSUInteger)times;
@end

@interface NSString (ODXCore_Hex)
- (unsigned int)od_hexInteger;
@end

@interface NSString (ODXCore_Escapes)
- (NSString *)od_stringByReplacingSQLEscapes;
@end

@interface NSString (ODXCore_Chars)
- (BOOL)od_hasNonAlphabetSymbols;
@end