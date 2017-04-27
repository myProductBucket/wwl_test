//
//  ChannelModel.h
//  wwl
//
//  Created by Mobile on 27/04/2017.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ACTIVE = 100,
    INACTIVE,
    STARTING,
} ChannelStatus;

@interface ChannelModel : NSObject

/// thumbnail image URL
@property (strong, nonatomic) NSString *thumbnail;
/// Channel Status
@property ChannelStatus status;
/// Editable or not
@property BOOL canEdit;
/// Channel ID
@property (strong, nonatomic) NSString *channelID;
/// Open Status
@property BOOL isOpen;
/// Private Status
@property BOOL isPrivate;
/// Streamable or not
@property BOOL canStream;
/// Admin Status
@property BOOL isAdmin;
/// Channel Name
@property (strong, nonatomic) NSString *channelName;
/// Logo image URL
@property (strong, nonatomic) NSString *logo;


- (id)initWith: (NSDictionary *)dic;

@end
