//
//  UINavigationBar+HKLocalizationChecker.m
//
//  Created by Hector Zarate / Tomasz Wyszomirski on 2/22/13.
//

#import "UIViewController+HKLocalizationChecker.h"
#import <objc/runtime.h>
#import "HKLocalizationChecker.h"

@implementation UIViewController (HKLocalizationChecker)

+ (void)initialize
{
    if (self == [UIViewController class]) {
        [self setup];
    }
}

+ (void)setup
{
    // swizzle setTitle
    Method originalMethod = class_getInstanceMethod(self, @selector(setTitle:));
    
    Method mine = class_getInstanceMethod(self, @selector(swappedSetTitle:));
    method_exchangeImplementations(originalMethod, mine);
}

- (void)swappedSetTitle:(NSString *)title
{
    if ([[HKLocalizationChecker sharedHKLocalizationChecker] isStringLocalized:title] == NO) {
        objc_setAssociatedObject(self, kOldColorKey, self.navigationController.navigationBar, OBJC_ASSOCIATION_RETAIN);
        self.navigationController.navigationBar.tintColor = [UIColor redColor];
        NSLog(@"Non-localized string \"%@\" in: %@", title, MethodNameFromCurrentStackTrace());
    } else {
        self.navigationController.navigationBar.tintColor = objc_getAssociatedObject(self, kOldColorKey);
    }
    
    [self swappedSetTitle:title];
}

@end
