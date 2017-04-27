//
//  APIConfig.h
//  8a-ios
//
//  Created by Mobile on 21/04/2017.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#ifndef APIConfig_h
#define APIConfig_h

#define DomainURL @"http://dev-api.wwl.tv"

#pragma mark - APIs

#define RequestConfirmationCode @"/api/v1/login/request-code"
#define LoginWithCredentials @"/api/v1/login"
#define GetUserProfileFields @"/api/v1/users/profile-fields"
#define GetChannels @"/api/v1/channels"
#define GetChannelDetails @"/api/v1/channels/%@/watch"

#endif /* APIConfig_h */
