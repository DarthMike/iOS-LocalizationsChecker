//
//  HKLocalizationChecker.h
//
//  Created by Hector Zarate / Tomasz Wyszomirski on 2/22/13.
//

#import <Foundation/Foundation.h>

/// Singleton which manages all state (in memory or disk) needed by the checker code.
@interface HKLocalizationChecker : NSObject

/// Typical singleton shared intance
+(HKLocalizationChecker *)sharedHKLocalizationChecker;

/// Queries if a string is localized. Checks if the string was somehow acquired from translation
-(BOOL)isStringLocalized:(NSString *)theString;

/// Adds a localized string to internal data structure. Generally this method is used with isStringLocalized: by the categories
-(void)addLocalizedWord:(NSString *)theString;

//This is a configuration value, to check if the view should be shown highlighted when a string is not localized
//Default is NO
@property (nonatomic, assign) BOOL showsFaultyWhenViewHidden;

@end
