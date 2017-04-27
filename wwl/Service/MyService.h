//
//  MyService.h
//  8a-ios
//
//  Created by Mobile on 21/04/2017.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseService.h"

@interface MyService : BaseService

+ (MyService *)shared;
/// Get Confirmation code by Phone Number
-(void)requestConfirmationCodeWithPhoneNum:(NSString *)phoneNum withCompletion:(void(^)(BOOL success,id res))block;

/// Login with phone number
-(void)loginWithPhoneNum:(NSString *)phoneNum confirmationCode: (NSString *)code withCompletion:(void(^)(BOOL success,id res))block;

/// Login with email
-(void)loginWithEmail:(NSString *)email password: (NSString *)password withCompletion:(void(^)(BOOL success,id res))block;

/// Get User Profile Fields
-(void)getUserProfileFieldsWithToken:(NSString *)token withCompletion:(void(^)(BOOL success,id res))block;

/// Get channels
-(void)getChannelsWithToken:(NSString *)token withCompletion:(void(^)(BOOL success,id res))block;

/// Get Channel Details
-(void)getChannelDetailsWithId:(NSString *)channelID token: (NSString *)token withCompletion:(void(^)(BOOL success,id res))block;

@end
