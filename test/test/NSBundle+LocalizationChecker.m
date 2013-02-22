//
//  NSBundle.m
//  test
//
//  Created by Miquel Angel Quinones Garcia on 2/22/13.
//  Copyright (c) 2013 Miquel Angel Quinones Garcia. All rights reserved.
//

#import "NSBundle+LocalizationChecker.h"
#import <objc/runtime.h>
#import "LocalizationChecker.h"

static Method originalMethod;


@implementation NSBundle (LocalizationChecker)
+ (void) initialize {
    if (self == [NSBundle class]) {
        originalMethod = class_getInstanceMethod(self, @selector(localizedStringForKey:value:table:));
         Method mine = class_getInstanceMethod(self, @selector(swappedLocalizedStringForKey:value:table:));
         method_exchangeImplementations(originalMethod, mine);
    }
}

- (NSString *)swappedLocalizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName {

   //put in dict key
    
    NSString* translated = [self swappedLocalizedStringForKey:key value:value table:tableName];
    
    
    BOOL defaultSupplied = (value != nil) && value.length > 0;
    
    if (!defaultSupplied) {
        value = @"__MYHACK_DEFAULTVAULE__";
    }
    
    
    BOOL keyIsSameAsReturned = (key == translated);
    
    if ((!defaultSupplied && [translated isEqualToString:key] && keyIsSameAsReturned)
        ||
        (defaultSupplied && [translated isEqualToString:value])) {

        //we don't have the string localized
        NSLog(@"*****NO STRING IS LOCALIZED********");
        
    } else {
        //string localized, add to structure
        
        
        [[LocalizationChecker sharedLocalizationChecker] addLocalizedWord:translated];
        
    }
    
    
    return translated;
    
}

@end
