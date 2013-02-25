//
//  HKLocalizationChecker.m
//
//  Created by Hector Zarate / Tomasz Wyszomirski on 2/22/13.
//

#import "HKLocalizationChecker.h"

const char *kIsFaultyKey = "IsFaulty";
const char *kOldColorKey = "OldColorKey";

inline NSString * MethodNameFromCurrentStackTrace()
{
    NSArray *stackTrace = [NSThread callStackSymbols];
    if (stackTrace.count > 2) {
        NSString *stackLine = stackTrace[2];
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"([\\+\\-]\\[.*\\])" options:0 error:NULL];
        NSTextCheckingResult *match = [regex firstMatchInString:stackLine options:0 range:NSMakeRange(0, stackLine.length)];
        if (match) {
            return [stackLine substringWithRange:match.range];
        }
    }
    return nil;
};


@interface HKLocalizationChecker ()
@property (strong, nonatomic) NSMutableDictionary *localizedWords;
@end


@implementation HKLocalizationChecker

    static HKLocalizationChecker *sharedInstance;

- (instancetype)init
{
    if (sharedInstance != nil) {
        return sharedInstance;
    }
    
    if (self = [super init]) {
        _localizedWords = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

+ (HKLocalizationChecker *)sharedHKLocalizationChecker
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    
    return sharedInstance;
}

- (BOOL)isStringLocalized:(NSString *)theString
{
    BOOL result = NO;
    
    NSString *filtered = theString;
    NSRange punctuation;
    do {
        punctuation = [filtered rangeOfCharacterFromSet:[NSCharacterSet punctuationCharacterSet]];
        if (punctuation.location != NSNotFound) {
            filtered = [filtered stringByReplacingCharactersInRange:punctuation withString:@""];
        }
        
    } while (punctuation.location != NSNotFound && filtered);
    
    NSRange decimal;
    do {
        decimal = [filtered rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]];
        if (decimal.location != NSNotFound) {
            filtered = [filtered stringByReplacingCharactersInRange:decimal withString:@""];
        }
    } while (decimal.location != NSNotFound && filtered);
    
    if ([self.localizedWords objectForKey:theString] || filtered.length == 0) {
        result = YES;
    }
    
    return result;
}

- (void)addLocalizedWord:(NSString *)theString
{
    [self.localizedWords setObject:[NSNull null] forKey:theString];
}

@end
