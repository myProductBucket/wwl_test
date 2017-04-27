//
//  PlayViewController.h
//  wwl
//
//  Created by Mobile on 27/04/2017.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChannelModel.h"

@interface PlayViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *channelUrlTF;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

- (void)setCurrentChannel: (ChannelModel *)model;

@end
