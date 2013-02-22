//
//  UINavigationBar+LocalisationChecker.m
//  test
//
//  Created by Hector Zarate on 2/22/13.
//  Copyright (c) 2013 Miquel Angel Quinones Garcia. All rights reserved.
//

#import "UIViewController+LocalisationChecker.h"
#import <objc/runtime.h>
#import "LocalizationChecker.h"

@implementation UIViewController (LocalisationChecker)

+ (void) initialize {
    if (self == [UIViewController class]) {
        [self setup];
    }
}

+ (void)setup {
    // swizzle setTitle
    Method originalMethod = class_getInstanceMethod(self, @selector(setTitle:));
    
    Method mine = class_getInstanceMethod(self, @selector(swappedSetTitle:));
    method_exchangeImplementations(originalMethod, mine);
}

- (void)swappedSetTitle:(NSString *)title {
    if ([[LocalizationChecker sharedLocalizationChecker] isStringLocalized:title] == NO) {
        objc_setAssociatedObject(self, "hackaton", self.navigationController.navigationBar, OBJC_ASSOCIATION_RETAIN);
        self.navigationController.navigationBar.tintColor = [UIColor redColor];
    } else {
        self.navigationController.navigationBar.tintColor = objc_getAssociatedObject(self, "hackaton");
    }
    
    [self swappedSetTitle:title];
}

@end
