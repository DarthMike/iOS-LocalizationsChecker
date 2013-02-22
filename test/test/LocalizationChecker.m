//
//  LocalizationChecker.m
//  test
//
//  Created by Hector Zarate on 2/22/13.
//  Copyright (c) 2013 Miquel Angel Quinones Garcia. All rights reserved.
//

#import "LocalizationChecker.h"

@implementation LocalizationChecker

-(id)init
{
    self = [super init];
    
    if (self)
    {
        _localizedWords = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

-(BOOL)isStringLocalized:(NSString *)theString
{
    BOOL result = NO;
    
    if ([self.localizedWords objectForKey:theString])
    {
        result = YES;
    }
    
    return result;
}

@end
