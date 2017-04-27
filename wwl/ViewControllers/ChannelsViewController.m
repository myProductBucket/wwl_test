//
//  ChannelsViewController.m
//  wwl
//
//  Created by Mobile on 27/04/2017.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#import "ChannelsViewController.h"
#import "ChannelCollectionViewCell.h"
#import "ChannelModel.h"
#import "PlayViewController.h"

@interface ChannelsViewController () <UICollectionViewDelegate, UICollectionViewDataSource> {
    NSMutableArray *channelsArr;
}

@end

@implementation ChannelsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.recordNowButton shadowForButton];
    [self.collectionView setAlwaysBounceVertical:YES];
    [self setTitle:@"Channels"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self fetchChannels];
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

#pragma mark - Manage Channels

- (void)fetchChannels {
    [self.noChannelFoundLabel setHidden:YES];
    channelsArr = [[NSMutableArray alloc] init];
    
    NSString *bearerToken = [NSString stringWithFormat:@"Bearer{%@}", [[AppDelegate shared] me].token];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[MyService shared] getChannelsWithToken:bearerToken withCompletion:^(BOOL success, id res) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (success) {
            NSLog(@"Channels: %@", res);
            if (![res[@"status"] isEqual:[NSNull null]] && [res[@"status"] isEqualToString:@"ok"]) {
                if (![res[@"data"] isEqual:[NSNull null]]) {
                    for (NSDictionary *item in res[@"data"]) {
                        ChannelModel *model = [[ChannelModel alloc] initWith:item];
                        [channelsArr addObject:model];
                    }
                    [self.collectionView reloadData];
                }
            }else {
                [self.noChannelFoundLabel setHidden:NO];
            }
        }else {
            [self.noChannelFoundLabel setHidden:NO];
        }
    }];
}

#pragma mark - UICollectionVewDelegate / UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return channelsArr.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(nWidth / 2 - 10, nWidth / 2 - 10);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ChannelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"channelCell" forIndexPath:indexPath];
    ChannelModel *model = channelsArr[indexPath.row];
    
    [cell.thumbnailImageView setImageWithURL:[NSURL URLWithDataRepresentation:[model.thumbnail dataUsingEncoding:NSUTF8StringEncoding] relativeToURL:nil] placeholderImage:nil];
    [cell.nameLabel setText:model.channelName];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ChannelModel *model = channelsArr[indexPath.row];
    
    PlayViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PlayViewController"];
    [vc setCurrentChannel:model];
//    [self.navigationController pushViewController:vc animated:YES];
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - UIButton Actions

- (IBAction)recordNowTouchUp:(UIButton *)sender {
}

@end
