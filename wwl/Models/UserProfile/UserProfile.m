//
//  UserProfile.m
//  8a-ios
//
//  Created by Mobile on 24/04/2017.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#import "UserProfile.h"


@implementation UserProfile

- (id)initWithCoder: (NSCoder *)decoder {
    if ((self = [super init])) {
        // decode properties, other class vars
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.email = [decoder decodeObjectForKey:@"email"];
        self.phone = [decoder decodeObjectForKey:@"phone"];
        self.token = [decoder decodeObjectForKey:@"token"];
    }
    return self;
}

- (void)encodeWithCoder: (NSCoder *)encoder {
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.email forKey:@"email"];
    [encoder encodeObject:self.phone forKey:@"phone"];
    [encoder encodeObject:self.token forKey:@"token"];
}

- (void)save {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:self];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:encodedObject forKey:CURRENT_USER];
    [userDefaults synchronize];
}

+ (UserProfile *)loadMyProfile {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:CURRENT_USER];
    UserProfile *object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return object;
}

//+ (UserProfile *) current {
//    static UserProfile *current = nil;

//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
    
//        if ([current load] == nil) {
//            current = [[UserProfile alloc] init];
//        }
//        current = [[UserProfile alloc] init];
//        current = [current load];

//    });
    
//    return current;
//}

@end
