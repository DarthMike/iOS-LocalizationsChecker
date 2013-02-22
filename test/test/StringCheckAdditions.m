//
//  StringCheckAdditions.m
//  test
//
//  Created by Miquel Angel Quinones Garcia on 2/22/13.
//  Copyright (c) 2013 Miquel Angel Quinones Garcia. All rights reserved.
//

#import "StringCheckAdditions.h"
#import <objc/runtime.h>

static Method originalMethod;


@implementation StringCheckAdditions
+ (void) initialize {
    if (self == [StringCheckAdditions class]) {
        [self setup];
    }
}

+ (void)setup {
    originalMethod = class_getClassMethod(self, @selector(localizedStringForKey:value:table:));
    
    
    Method mine = class_getClassMethod(self, @selector(swappedLocalizedStringForKey:value:table:));
    method_exchangeImplementations(originalMethod, mine);
}

- (NSString *)swappedLocalizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName {
#warning TODO
    return [self localizedStringForKey:key value:value table:tableName];
}


@end
