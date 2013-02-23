//
//  ViewController.m
//  test
//
//  Created by Miquel Angel Quinones Garcia / Paweł Wrzosek on 2/22/13.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupLocalizedStrings];
}

- (void)setupLocalizedStrings
{
    //Try to override color for the string with bad translation
    self.coolLabel.backgroundColor = [UIColor greenColor];
    self.coolLabel.text = NSLocalizedString(@"notTranslated",@"");;
    self.coolLabel.backgroundColor = [UIColor greenColor];
    
    self.noBgLabel.text = NSLocalizedString(@"key1", @"");

    
    [self.button setTitle:NSLocalizedString(@"key2", @"") forState:UIControlStateNormal];
    [self.button setTitle:@"hardcoded" forState:UIControlStateSelected];
    
    [self.button2 setTitle:@"hardcoded" forState:UIControlStateNormal];
    [self.button2 setTitle:NSLocalizedString(@"key3", @"") forState:UIControlStateSelected];
    
    self.title = @"NotTranslated";
}

@end
