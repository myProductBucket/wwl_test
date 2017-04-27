//
//  ViewController.m
//  8a-ios
//
//  Created by Uncovered on 4/20/17.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#import "ViewController.h"
#import "SignInViewController.h"
#import "ProfileViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIButton Actions

- (IBAction)watchNewsTouchUp:(UIButton *)sender {
}

- (IBAction)reportNewsTouchUp:(UIButton *)sender {
    UserProfile *me = [UserProfile loadMyProfile];
    if (me) {
        // If the user already signed in, ...
        [[AppDelegate shared] setMe:me];
        [self showProfileVC];
    }else {
        [self showSignInVC];
    }
}

#pragma mark - Custom Methods

- (void)showProfileVC {
    ProfileViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showSignInVC {
    SignInViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
