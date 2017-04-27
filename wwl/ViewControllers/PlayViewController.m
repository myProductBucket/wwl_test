//
//  PlayViewController.m
//  wwl
//
//  Created by Mobile on 27/04/2017.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#import "PlayViewController.h"
#import "ChannelDetailModel.h"
@import AVFoundation;
@import AVKit;

@interface PlayViewController () {
    ChannelModel *currentChannel;
    ChannelDetailModel *currentChannelDetail;
}

@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:APP_NAME];
    [self.playButton shadowForButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self fetchChannelDetail];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeLeft;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL)shouldAutorotate {
    return YES;
}

#pragma mark - Channel Detail Management

- (void)fetchChannelDetail {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[MyService shared] getChannelDetailsWithId:currentChannel.channelID token:[AppDelegate shared].me.token withCompletion:^(BOOL success, id res) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (success) {
            if (![res[@"status"] isEqual:[NSNull null]] && [res[@"status"] isEqualToString:@"ok"]) {
                currentChannelDetail = [[ChannelDetailModel alloc] initWith:res[@"data"]];
                
                [self.thumbnailImageView setImageWithURL:[NSURL URLWithDataRepresentation:[currentChannelDetail.thumbnail dataUsingEncoding:NSUTF8StringEncoding] relativeToURL:nil] placeholderImage:nil];
                [self.channelUrlTF setText:currentChannelDetail.hlsURL];
                
            }else {
                
            }
        }else {
            
        }
    }];
}

#pragma mark - Play Video

- (IBAction)playTouchUp:(UIButton *)sender {
    if (currentChannelDetail.hlsURL == nil) {
        return;
    }
    
    [self playVideo];
}

- (void)playVideo {
    // Create a AVPlayer
    AVPlayer *player = [AVPlayer playerWithURL: [NSURL URLWithDataRepresentation:[currentChannelDetail.hlsURL dataUsingEncoding:NSUTF8StringEncoding] relativeToURL:nil]];
    
    // Create a player view controller
    AVPlayerViewController *controller = [[AVPlayerViewController alloc] init];
    [controller setPlayer:player];
    [controller setShowsPlaybackControls:YES];
    [controller setAllowsPictureInPicturePlayback:YES];
    [player play];
    
    // show the view controller
    [self addChildViewController:controller];
    [controller didMoveToParentViewController:self];
    [self.view addSubview:controller.view];
    [controller.view setFrame:self.view.frame];
    [self.view setAutoresizesSubviews:YES];
}

#pragma mark - Public Methods

- (void)setCurrentChannel: (ChannelModel *)model {
    currentChannel = model;
}

@end
