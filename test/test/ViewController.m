//
//  ViewController.m
//  test
//
//  Created by Miquel Angel Quinones Garcia on 2/22/13.
//  Copyright (c) 2013 Miquel Angel Quinones Garcia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupLocalizedStrings];
}

- (void)setupLocalizedStrings
{
    self.coolLabel.backgroundColor = [UIColor greenColor];
    self.coolLabel.text = NSLocalizedString(@"fdsklhhljkdgslhjkadgs", @"");
    self.coolLabel.backgroundColor = [UIColor greenColor];
    
    self.coolLabel.hidden = YES;
}

@end
