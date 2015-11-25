// ODPath.m
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

#import "ODPath.h"

@implementation ODPath

/** Path to applications directory (Applications) */
+ (NSString *)applictions {
    return ODSearchFirstPathForDirectoryInUserDomain(NSApplicationDirectory);
}

/** Path to library directory (Library) */
+ (NSString *)library {
    return ODSearchFirstPathForDirectoryInUserDomain(NSLibraryDirectory);
}

/** Path to user home directories (Users) */
+ (NSString *)users {
    return ODSearchFirstPathForDirectoryInUserDomain(NSUserDirectory);
}

/** Path to current user home directory (Users/usrname/) */
+ (NSString *)home {
    return NSHomeDirectory();
}

/** Path to documentation directory (Documentation) */
+ (NSString *)documentation {
    return ODSearchFirstPathForDirectoryInUserDomain(NSDocumentationDirectory);
}

/** Path to documents directory (Documents) */
+ (NSString *)documents {
    return ODSearchFirstPathForDirectoryInUserDomain(NSDocumentDirectory);
}

// TODO:
// NSCoreServiceDirectory - location of CoreServices directory (System/Library/CoreServices)
// NSAutosavedInformationDirectory NS_ENUM_AVAILABLE(10_6, 4_0) - location of autosaved documents (Documents/Autosaved)

/** Path to users's desktoop directory (~/Desktop) */
+ (NSString *)desktop {
    return ODSearchFirstPathForDirectoryInUserDomain(NSDesktopDirectory);
}

/** Path to discardable cache files directory (Library/Caches) */
+ (NSString *)caches {
    return ODSearchFirstPathForDirectoryInUserDomain(NSCachesDirectory);
}

/** Path to application support files (Library/Application Support) */
+ (NSString *)applictionSupport {
    return ODSearchFirstPathForDirectoryInUserDomain(NSApplicationSupportDirectory);
}

// TODO:
// NSDownloadsDirectory NS_ENUM_AVAILABLE(10_5, 2_0) = 15,              - location of the user's "Downloads" directory
// NSInputMethodsDirectory NS_ENUM_AVAILABLE(10_6, 4_0) = 16,           - input methods (Library/Input Methods)
// NSMoviesDirectory NS_ENUM_AVAILABLE(10_6, 4_0) = 17,                 - location of user's Movies directory (~/Movies)
// NSMusicDirectory NS_ENUM_AVAILABLE(10_6, 4_0) = 18,                  - location of user's Music directory (~/Music)
// NSPicturesDirectory NS_ENUM_AVAILABLE(10_6, 4_0) = 19,               - location of user's Pictures directory (~/Pictures)
// NSPrinterDescriptionDirectory NS_ENUM_AVAILABLE(10_6, 4_0) = 20,     - location of system's PPDs directory (Library/Printers/PPDs)
// NSSharedPublicDirectory NS_ENUM_AVAILABLE(10_6, 4_0) = 21,           - location of user's Public sharing directory (~/Public)
// NSPreferencePanesDirectory NS_ENUM_AVAILABLE(10_6, 4_0) = 22,        - location of the PreferencePanes directory for use with System Preferences (Library/PreferencePanes)
// NSApplicationScriptsDirectory NS_ENUM_AVAILABLE(10_8, NA) = 23,      - location of the user scripts folder for the calling application (~/Library/Application Scripts/code-signing-id)
// NSItemReplacementDirectory NS_ENUM_AVAILABLE(10_6, 4_0) = 99,        - For use with NSFileManager's URLForDirectory:inDomain:appropriateForURL:create:error:
// NSAllApplicationsDirectory = 100,                                    - all directories where applications can occur
// NSAllLibrariesDirectory = 101,                                       - all directories where resources can occur

/** Path to trash bin */
+ (NSString *)trash NS_AVAILABLE_MAC(10_8) {
    return ODSearchFirstPathForDirectoryInUserDomain(NSTrashDirectory);
}

// TODO:
//+ (NSString *)preferences {
//    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject
//            stringByAppendingString:@"/Preferences"];
//}

/** Path to tmp directory (/tmp) */
+ (NSString *)temp {
    return NSTemporaryDirectory();
}

/** Path to file in resource directory */
+ (NSString *)pathToResourcesWithName:(NSString *)name {
    return [[NSBundle mainBundle] pathForResource:[name stringByDeletingPathExtension]
                                           ofType:[name pathExtension]];
}

@end
