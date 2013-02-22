//
//  NSBundle.m
//  test
//
//  Created by Miquel Angel Quinones Garcia on 2/22/13.
//  Copyright (c) 2013 Miquel Angel Quinones Garcia. All rights reserved.
//

#import "StringCheckAdditions.h"
#import <objc/runtime.h>

static Method originalMethod;


@implementation NSBundle (StringCheckAdditions)
+ (void) initialize {
    if (self == [NSBundle class]) {
        originalMethod = class_getInstanceMethod(self, @selector(localizedStringForKey:value:table:));
         Method mine = class_getInstanceMethod(self, @selector(swappedLocalizedStringForKey:value:table:));
         method_exchangeImplementations(originalMethod, mine);
    }
}

- (NSString *)swappedLocalizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName {

   //put in dict key
    
    NSString* returned = [self swappedLocalizedStringForKey:key value:value table:tableName];
    
    
    BOOL defaultSupplied = (value != nil) && value.length > 0;
    BOOL keyIsSameAsReturned = (key == returned);
    
    if ((!defaultSupplied && [returned isEqualToString:key] )
        ||
        (defaultSupplied && [returned isEqualToString:value])) {

        //we don't have the string localized
        NSLog(@"*****NO STRING IS LOCALIZED********");
#warning WHEN VALUE EXISTS AND IS THE SAME AS KEY, WE FAIL TO RECOGNIZE GOOD STRING
        
    } else {
        //string localized, add to structure
    }
    
    
    return returned;
    
}

@end
