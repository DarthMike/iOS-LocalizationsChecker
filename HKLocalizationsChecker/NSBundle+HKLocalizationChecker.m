//
//  NSBundle+HKLocalizationChecker.m
//
//  Created by Miquel Angel Quinones Garcia / Paweł Wrzosek on 2/22/13.
//

#import "NSBundle+HKLocalizationChecker.h"
#import <objc/runtime.h>
#import "HKLocalizationChecker.h"

static Method originalMethod;


@implementation NSBundle (HKLocalizationChecker)
+ (void) initialize {
    //Swizzle method implementations which get string from NSBundle strings file
    if (self == [NSBundle class]) {
        originalMethod = class_getInstanceMethod(self, @selector(localizedStringForKey:value:table:));
         Method mine = class_getInstanceMethod(self, @selector(swappedLocalizedStringForKey:value:table:));
         method_exchangeImplementations(originalMethod, mine);
    }
}

- (NSString *)swappedLocalizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName {
    //Get the original (from file or not) translated string
    NSString* translated = [self swappedLocalizedStringForKey:key value:value table:tableName];
    
    //Apple docs state:
    //A localized version of the string designated by key in table tableName.
    //If value is nil or an empty string, and a localized string is not found in the table, returns key.
    //If key and value are both nil, returns the empty string.
    
    //Need to check if programmer supplied default key
    BOOL defaultSupplied = (value != nil) && value.length > 0;
    if (!defaultSupplied) {
        value = @"__MYHACK_DEFAULTVAULE__";
    }
    
    //Need to see if returned string is pointing to same string as returned, because there was no string in disk
    BOOL keyIsSameAsReturned = (key == translated);
    
    if ((!defaultSupplied && [translated isEqualToString:key] && keyIsSameAsReturned)
        ||
        (defaultSupplied && [translated isEqualToString:value])) {

        //We don't have the string localized
        //NSLog(@"*****NO STRING IS LOCALIZED********");
        //Just as a reference. 
    } else {
        //String localized, add to structure
        //This will be checked later on when a string is set to a UI component
        [[HKLocalizationChecker sharedHKLocalizationChecker] addLocalizedWord:translated];
    }
    
    return translated;
}

@end
