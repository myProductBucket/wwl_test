//
//  ProfileViewController.m
//  8a-ios
//
//  Created by Mobile on 21/04/2017.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#import "ProfileViewController.h"
#import "UserDataModel.h"
#import "ChannelsViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.cancelButton shadowForButton];
    [self.saveButton shadowForButton];
//    [self.logoutButton shadowForButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getProfileFields];
    
    [self setTitle:APP_NAME];
    UIBarButtonItem *statusBarItem;
    UIButton *statusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    if ([UserProfile loadMyProfile]) {
        [statusButton setBackgroundImage:[UIImage imageNamed:@"status_login"] forState:UIControlStateNormal];
    }else {
        [statusButton setBackgroundImage:[UIImage imageNamed:@"status_logout"] forState:UIControlStateNormal];
    }
    [statusButton sizeToFit];
    statusBarItem = [[UIBarButtonItem alloc] initWithCustomView:statusButton];
    self.navigationItem.rightBarButtonItem = statusBarItem;
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

#pragma mark - Get Profile Fields

- (void)getProfileFields {
    NSString *bearerToken = [NSString stringWithFormat:@"Bearer{%@}", [[AppDelegate shared] me].token];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[MyService shared] getUserProfileFieldsWithToken:bearerToken withCompletion:^(BOOL success, id res) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (success) {
            NSLog(@"%@", res);
            if (res == nil || res[@"data"] == nil || [res[@"data"] isEqual:[NSNull null]]) {
                NSLog(@"Your Profile Data - Nothing");
            }else {
                NSArray *arr = res[@"data"];
                NSMutableArray *dataArr = [[NSMutableArray alloc] init];
                for (NSDictionary *dic in arr) {
                    UserDataModel *model = [[UserDataModel alloc] initWith:dic];
                    if ([model.label isEqualToString:@"Name"]) {
//                        [self.nameTF setText:model.label];
                        [self.nameTF setText:model.valueStr];
                    }else if ([model.label isEqualToString:@"Profile Picture"]) {
//                        self.photoImageView setImage:model.?
                    }else if ([model.label isEqualToString:@"Bio"]) {
                        [self.bioTextView setText:model.valueStr];
                    }
                    [dataArr addObject:model];
                }
                
                [[AppDelegate shared] me].dataArr = dataArr;
            }
        }else {
            
        }
    }];
}

#pragma mark - UIButton Actions

- (IBAction)logOutTouchUp:(UIButton *)sender {
    [[AppDelegate shared] logOut];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)cancelTouchUp:(UIButton *)sender {
    ChannelsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ChannelsViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)saveTouchUp:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
