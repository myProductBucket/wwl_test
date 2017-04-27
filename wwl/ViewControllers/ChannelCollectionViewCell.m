//
//  ChannelCollectionViewCell.m
//  wwl
//
//  Created by Mobile on 27/04/2017.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#import "ChannelCollectionViewCell.h"

@implementation ChannelCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.contentV.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.contentV.layer setBorderWidth:1];
    [self.contentV.layer setCornerRadius:5];
    
    [self.thumbnailImageView setClipsToBounds:YES];
}

@end
