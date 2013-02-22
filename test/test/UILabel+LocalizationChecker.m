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

//@interface UILabel ()
//@property (nonatomic, strong) UIColor *originalBackgroundColor;
//@end
//
//@implementation UILabel
//@synthesize originalBackgroundColor;
//@end

@implementation UILabel (LocalizationChecker)

// What happens when text is called from IB ?

+ (void) initialize {
    if (self == [UILabel class]) {
        [self setup];
    }
}

+ (void)setup {
    // swizzle setText
    Method originalMethod = class_getInstanceMethod(self, @selector(setText:));
    
    Method mine = class_getInstanceMethod(self, @selector(swappedSetText:));
    method_exchangeImplementations(originalMethod, mine);
    
    // swizzle setValue:forKey:
    Method originalSetValueMethod = class_getInstanceMethod(self, @selector(awakeFromNib));
    Method mineSetValueMethod = class_getInstanceMethod(self, @selector(swappedAwakeFromNib));
    method_exchangeImplementations(originalSetValueMethod, mineSetValueMethod);
}

- (void)swappedSetText:(NSString *)text {
    
    if ([[LocalizationChecker sharedLocalizationChecker] isStringLocalized:text] == NO) {
        [self setBackgroundColor:[UIColor redColor]];
    } else {
//        [self setBackgroundColor:self.originalBackgroundColor];
    }
    
    [self swappedSetText:text];
}

- (void)swappedAwakeFromNib
{
    if ([self isKindOfClass:[UILabel class]])
    {
        [self swappedAwakeFromNib];
        
        if ([[LocalizationChecker sharedLocalizationChecker] isStringLocalized:self.text] == NO) {
//            self.originalBackgroundColor = self.backgroundColor;
            [self setBackgroundColor:[UIColor redColor]];
        }
    }
}

@end
