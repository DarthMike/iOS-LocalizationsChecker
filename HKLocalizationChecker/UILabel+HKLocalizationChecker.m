//
//  UILabel+HKLocalizationChecker.m
//
//  Created by Hector Zarate / Tomasz Wyszomirski on 2/22/13.
//

#import "UILabel+HKLocalizationChecker.h"
#import "HKLocalizationChecker.h"
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>

#define NONLOCALIZED_VIEW_BACKGROUND_COLOR [UIColor redColor]

@implementation UILabel (HKLocalizationChecker)

// What happens when text is called from IB ?

+ (void)initialize
{
    if (self == [UILabel class]) {
        [self setup];
    }
}

+ (void)setup
{
    // swizzle setText
    Method originalMethod = class_getInstanceMethod(self, @selector(setText:));
    
    Method mine = class_getInstanceMethod(self, @selector(swappedSetText:));
    method_exchangeImplementations(originalMethod, mine);
    
    // swizzle setValue:forKey:
    Method originalSetValueMethod = class_getInstanceMethod(self, @selector(awakeFromNib));
    Method mineSetValueMethod = class_getInstanceMethod(self, @selector(swappedAwakeFromNib));
    method_exchangeImplementations(originalSetValueMethod, mineSetValueMethod);
}

- (void)swappedSetText:(NSString *)text
{
    objc_setAssociatedObject(self, kIsFaultyKey, @NO, OBJC_ASSOCIATION_RETAIN);
    
    if ([[HKLocalizationChecker sharedHKLocalizationChecker] isStringLocalized:text] == NO) {
        // Check for 'secure' labels. On UITextFields, internally apple's implementation swaps the
        // actual characters for a set of unicode 'black dots'. If our label is all 'black dots', we are dealing
        // with a secure UITextField, which shouldn't be treated as faulty.
        NSMutableString* secure = [NSMutableString stringWithCapacity:text.length];
        for (int i = 0; i < text.length; ++i) {
            [secure appendString:@"\u25CF"];  //The ●
        }
        
        if (![secure isEqualToString:text]) {
            objc_setAssociatedObject(self, kIsFaultyKey, @YES, OBJC_ASSOCIATION_RETAIN);
            NSLog(@"Non-localized string \"%@\" in: %@", text, MethodNameFromCurrentStackTrace());
            
            [self setBackgroundColorImpl:NONLOCALIZED_VIEW_BACKGROUND_COLOR];
        }
    } else {
        id oldColor = objc_getAssociatedObject(self, kOldColorKey);
        [self setBackgroundColor:oldColor];
    }
    
    [self swappedSetText:text];
}

- (void)swappedAwakeFromNib
{
    if ([self isKindOfClass:[UILabel class]]) {
        [self swappedAwakeFromNib];
        
        if ([[HKLocalizationChecker sharedHKLocalizationChecker] isStringLocalized:self.text] == NO) {
            objc_setAssociatedObject(self, kOldColorKey, self.backgroundColor, OBJC_ASSOCIATION_RETAIN);
            [self setBackgroundColor:NONLOCALIZED_VIEW_BACKGROUND_COLOR];
        }
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    BOOL isFaulty = [objc_getAssociatedObject(self, kIsFaultyKey) boolValue];
    if (!isFaulty) {
        [self setBackgroundColorImpl:backgroundColor];
    }
}

- (void)setHidden:(BOOL)hidden
{
    if (![HKLocalizationChecker sharedHKLocalizationChecker].showsFaultyWhenViewHidden) {
        self.layer.hidden = hidden;
    }
}

- (void)setBackgroundColorImpl:(UIColor *)backgroundColor
{
    self.layer.backgroundColor = backgroundColor.CGColor;
}

@end
