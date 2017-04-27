//
//  ChannelsViewController.h
//  wwl
//
//  Created by Mobile on 27/04/2017.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChannelsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *noChannelFoundLabel;
@property (weak, nonatomic) IBOutlet UIButton *recordNowButton;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
