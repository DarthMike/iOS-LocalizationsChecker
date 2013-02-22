//
//  LocalizationChecker.m
//  test
//
//  Created by Hector Zarate on 2/22/13.
//  Copyright (c) 2013 Miquel Angel Quinones Garcia. All rights reserved.
//

#import "LocalizationChecker.h"

@interface LocalizationChecker ()
@property (strong, nonatomic) NSMutableDictionary *localizedWords;
@end


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
    
    //Trims decimal and punctuation character set to be able to not consider strings only composed of numbers (not translated)
    NSCharacterSet* punctuation = [NSCharacterSet punctuationCharacterSet];
    NSCharacterSet* decimal = [NSCharacterSet decimalDigitCharacterSet];
    NSString* filtered = [[theString stringByTrimmingCharactersInSet:punctuation] stringByTrimmingCharactersInSet:decimal];
    
    if ([self.localizedWords objectForKey:theString] || filtered.length == 0)
    {
        result = YES;
    }
    
    return result;
}

-(void)addLocalizedWord:(NSString *)theString
{
    [self.localizedWords setObject:[NSNull null] forKey:theString];
}

@end
