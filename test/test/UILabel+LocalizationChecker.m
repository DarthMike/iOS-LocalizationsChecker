//
//  UILabel+LocalizationChecker.m
//  test
//
//  Created by Hector Zarate on 2/22/13.
//  Copyright (c) 2013 Miquel Angel Quinones Garcia. All rights reserved.
//

#import "UILabel+LocalizationChecker.h"
#import "LocalizationChecker.h"
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>

static const char *kIsFaultyKey = "IsFaulty";

@implementation UILabel (LocalizationChecker)

// What happens when text is called from IB ?

+ (void) initialize {
    if (self == [UILabel class]) {
        [self setup];
    }
}

+ (void)setup {
    Method originalMethod = class_getInstanceMethod(self, @selector(setText:));
    
    Method mine = class_getInstanceMethod(self, @selector(swappedSetText:));
    method_exchangeImplementations(originalMethod, mine);
}

- (void)swappedSetText:(NSString *)text {
    objc_setAssociatedObject(self, kIsFaultyKey, @NO, OBJC_ASSOCIATION_RETAIN);
    
    if ([[LocalizationChecker sharedLocalizationChecker] isStringLocalized:text] == NO) {
    objc_setAssociatedObject(self, kIsFaultyKey, @YES, OBJC_ASSOCIATION_RETAIN);
        [self setBackgroundColorImpl:[UIColor redColor]];
    }
    
    [self swappedSetText:text];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    
    id r =  objc_getAssociatedObject(self, kIsFaultyKey);
    BOOL isFaulty = [r boolValue];
    if (!isFaulty) {
        [self setBackgroundColorImpl:backgroundColor];
    }
}

- (void)setBackgroundColorImpl:(UIColor *)backgroundColor {
     self.layer.backgroundColor = backgroundColor.CGColor;
}
@end
