//
//  UILabel+LocalizationChecker.m
//  test
//
//  Created by Hector Zarate on 2/22/13.
//  Copyright (c) 2013 Miquel Angel Quinones Garcia. All rights reserved.
//

#import "UILabel+LocalizationChecker.h"
#import <objc/runtime.h>

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
#warning TODO
    
        [self setBackgroundColor:[UIColor redColor]];
    
    [self swappedSetText:text];
}


@end
