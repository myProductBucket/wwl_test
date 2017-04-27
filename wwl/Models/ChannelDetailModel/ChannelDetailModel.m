//
//  ChannelDetailModel.m
//  wwl
//
//  Created by Mobile on 27/04/2017.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#import "ChannelDetailModel.h"

@implementation ChannelDetailModel

- (id)initWith: (NSDictionary *)dic {
    self = [super init];
    
    self.status = (dic[@"status"] == nil || [dic[@"status"] isEqual:[NSNull null]])? INACTIVE: [self channelStatusFromString:dic[@"status"]];
    self.channelID = (dic[@"id"] == nil || [dic[@"id"] isEqual:[NSNull null]])? nil: dic[@"id"];
    self.channelName = (dic[@"name"] == nil || [dic[@"name"] isEqual:[NSNull null]])? nil: dic[@"name"];
    self.thumbnail = (dic[@"thumbnail"] == nil || [dic[@"thumbnail"] isEqual:[NSNull null]])? nil: ((dic[@"thumbnail"][@"url"] == nil || [dic[@"thumbnail"][@"url"] isEqual:[NSNull null]])? nil: dic[@"thumbnail"][@"url"]);
    self.hlsURL = (dic[@"hls_url"] == nil || [dic[@"hls_url"] isEqual:[NSNull null]])? nil: dic[@"hls_url"];
    self.rtmpURL = (dic[@"rtmp_url"] == nil || [dic[@"rtmp_url"] isEqual:[NSNull null]])? nil: dic[@"rtmp_url"];
    
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
