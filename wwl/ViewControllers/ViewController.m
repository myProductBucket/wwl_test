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
    
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
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

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self setTitle:@""];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIButton Actions

- (IBAction)watchNewsTouchUp:(UIButton *)sender {
    sender.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    
}

- (IBAction)reportNewsTouchUp:(UIButton *)sender {
    sender.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    
    UserProfile *me = [UserProfile loadMyProfile];
    if (me) {
        // If the user already signed in, ...
        [[AppDelegate shared] setMe:me];
        [self showProfileVC];
    }else {
        [self showSignInVC];
    }
}

// ---
- (IBAction)reportNexsDown:(UIButton *)sender {
    sender.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
}
- (IBAction)reportNewsTouchUpOutside:(UIButton *)sender {
    sender.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
}
- (IBAction)watchNewsDown:(UIButton *)sender {
    sender.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
}
- (IBAction)watchNewsTouchUpOutside:(UIButton *)sender {
    sender.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
}

#pragma mark - Custom Methods

- (void)initUI {
    
    [self.reportNewButton shadowForButton];
    [self.watchNewButton shadowForButton];
    
    [self.buttonWidthConstraint setConstant: nWidth * 250.0f / 375.0f];
}

- (void)showProfileVC {
    ProfileViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showSignInVC {
    SignInViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SignInViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
