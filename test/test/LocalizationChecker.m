//
//  LocalizationChecker.m
//  test
//
//  Created by Hector Zarate on 2/22/13.
//  Copyright (c) 2013 Miquel Angel Quinones Garcia. All rights reserved.
//

#import "LocalizationChecker.h"

@implementation LocalizationChecker

    static LocalizationChecker *sharedInstance;

-(id)init
{
    if (sharedInstance != nil) {
        return sharedInstance;
    }
    
    self = [super init];
    
    if (self)
    {
        _localizedWords = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

+(LocalizationChecker *)sharedLocalizationChecker
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    
    return sharedInstance;
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
