//
//  LocalizationChecker.h
//  test
//
//  Created by Hector Zarate on 2/22/13.
//  Copyright (c) 2013 Miquel Angel Quinones Garcia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalizationChecker : NSObject


// This is the singleton that will handle the data structure.

@property (strong, nonatomic) NSMutableDictionary *localizedWords;

+(LocalizationChecker *)sharedLocalizationChecker;

-(BOOL)isStringLocalized:(NSString *)theString;

@end
