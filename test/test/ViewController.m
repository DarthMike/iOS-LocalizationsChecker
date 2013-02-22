//
//  ViewController.m
//  test
//
//  Created by Miquel Angel Quinones Garcia on 2/22/13.
//  Copyright (c) 2013 Miquel Angel Quinones Garcia. All rights reserved.
//

#import "ViewController.h"
#import "LocalizationChecker.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.coolLabel.text = @"hello";

    [LocalizationChecker sharedLocalizationChecker];
}

@end
