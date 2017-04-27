//
//  ChannelModel.m
//  wwl
//
//  Created by Mobile on 27/04/2017.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#import "ChannelModel.h"

@implementation ChannelModel

- (id)initWith: (NSDictionary *)dic {
    self = [super init];
    
    self.thumbnail = (dic[@"thumbnail"] == nil || [dic[@"thumbnail"] isEqual:[NSNull null]])? nil: ((dic[@"thumbnail"][@"url"] == nil || [dic[@"thumbnail"][@"url"] isEqual:[NSNull null]])? nil: dic[@"thumbnail"][@"url"]);
    self.logo = (dic[@"logo"] == nil || [dic[@"logo"] isEqual:[NSNull null]])? nil: ((dic[@"logo"][@"url"] == nil || [dic[@"logo"][@"url"] isEqual:[NSNull null]])? nil: dic[@"logo"][@"url"]);
    self.status = (dic[@"status"] == nil || [dic[@"status"] isEqual:[NSNull null]])? INACTIVE: [self channelStatusFromString:dic[@"status"]];
    self.canEdit = (dic[@"can_edit"] == nil || [dic[@"can_edit"] isEqual:[NSNull null]])? NO: [dic[@"can_edit"] boolValue];
    self.channelID = (dic[@"id"] == nil || [dic[@"id"] isEqual:[NSNull null]])? nil: dic[@"id"];
    self.isOpen = (dic[@"is_open"] == nil || [dic[@"is_open"] isEqual:[NSNull null]])? NO: [dic[@"is_open"] boolValue];
    self.isPrivate = (dic[@"is_private"] == nil || [dic[@"is_private"] isEqual:[NSNull null]])? NO: [dic[@"is_private"] boolValue];
    self.canStream = (dic[@"can_stream"] == nil || [dic[@"can_stream"] isEqual:[NSNull null]])? NO: [dic[@"can_stream"] boolValue];
    self.isAdmin = (dic[@"is_admin"] == nil || [dic[@"is_admin"] isEqual:[NSNull null]])? NO: [dic[@"is_admin"] boolValue];
    self.channelName = (dic[@"name"] == nil || [dic[@"name"] isEqual:[NSNull null]])? nil: dic[@"name"];
    
    return self;
}

- (ChannelStatus)channelStatusFromString: (NSString *)string {
    if ([string isEqualToString:@"active"]) {
        return ACTIVE;
    }else if ([string isEqualToString:@"inactive"]) {
        return INACTIVE;
    }else {
        return STARTING;
    }
}

@end
