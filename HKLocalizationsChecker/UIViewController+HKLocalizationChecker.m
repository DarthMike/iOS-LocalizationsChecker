//
//  UINavigationBar+HKLocalizationChecker.m
//  test
//
//  Created by Hector Zarate / Tomasz Wyszomirski on 2/22/13.
//

#import "UIViewController+HKLocalizationChecker.h"
#import <objc/runtime.h>
#import "HKLocalizationChecker.h"

@implementation UIViewController (HKLocalizationChecker)

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
    if ([[HKLocalizationChecker sharedHKLocalizationChecker] isStringLocalized:title] == NO) {
        objc_setAssociatedObject(self, "hackaton", self.navigationController.navigationBar, OBJC_ASSOCIATION_RETAIN);
        self.navigationController.navigationBar.tintColor = [UIColor redColor];
        NSLog(@"Non-localized string \"%@\" in: %@", title, [[self class] methodNameFromStackTrace]);
    } else {
        self.navigationController.navigationBar.tintColor = objc_getAssociatedObject(self, "hackaton");
    }
    
    [self swappedSetTitle:title];
}

+ (NSString *)methodNameFromStackTrace {
    NSArray *stackTrace = [NSThread callStackSymbols];
    if (stackTrace.count <= 2) {
        return nil;
    }
    NSString *stackLine = stackTrace[2];
    stackLine = [stackLine stringByReplacingOccurrencesOfString:@" +" withString:@" "
                                                        options:NSRegularExpressionSearch
                                                          range:NSMakeRange(0, stackLine.length)];
    NSArray *stackComponents = [stackLine componentsSeparatedByString:@" "];
    stackComponents = [stackComponents subarrayWithRange:NSMakeRange(3, 2)];
    return [stackComponents componentsJoinedByString:@" "];
}

@end
