//
//  ChannelDetailModel.h
//  wwl
//
//  Created by Mobile on 27/04/2017.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChannelModel.h"

@interface ChannelDetailModel : NSObject

@property ChannelStatus status;
@property (strong, nonatomic) NSString *channelID;
@property (strong, nonatomic) NSString *channelName;
@property (strong, nonatomic) NSString *hlsURL;
@property (strong, nonatomic) NSString *rtmpURL;
@property (strong, nonatomic) NSString *thumbnail;

- (id)initWith: (NSDictionary *)dic;

@end
