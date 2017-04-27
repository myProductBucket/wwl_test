//
//  ConfirmCodeViewController.m
//  8a-ios
//
//  Created by Mobile on 21/04/2017.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#import "ConfirmCodeViewController.h"
#import "ProfileViewController.h"

@interface ConfirmCodeViewController () {
    NSString *phoneNum;
}

@end

@implementation ConfirmCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:APP_NAME];
    [self initUI];
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

- (void)initUI {
    [self.errorLabel setHidden:YES];
    
    [self.buttonWidthConstraint setConstant:nWidth * 250 / 375.0];
    [self.textFieldHeightConstraint setConstant:nHeight * 50 / 667.0];
    
    [self.nextButton shadowForButton];
    [self.notReceivedButton shadowForButton];
    
    UIToolbar *accessoryView = [[UIToolbar alloc] init];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:nil action:@selector(dismissKeyboard)];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [accessoryView sizeToFit];
    [accessoryView setItems:[NSArray arrayWithObjects: flexSpace,doneButton, nil]];
    
    [self.confirmCodeTF setInputAccessoryView:accessoryView];
}

#pragma mark - UIButton Actions

- (IBAction)nextTouchUp:(UIButton *)sender {
    sender.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    
    [self.errorLabel setHidden:YES];
    
    NSString *code = [self.confirmCodeTF text];
    if (code == nil || code.length < 4) {
        [self showAlertWithTitle:@"" message:@"Please input the valid code!"];
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[MyService shared] loginWithPhoneNum:phoneNum confirmationCode:code withCompletion:^(BOOL success, id res) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if (success) {
            
            if ([res[@"status"] isEqualToString:@"ok"]) {
                NSLog(@"Token: %@", res[@"token"]);
                
                UserProfile *user = [[UserProfile alloc] init];
                [user setPhone:phoneNum];
                [user setToken:res[@"token"]];
                if (res[@"isProfileFilled"] == nil || [res[@"isProfileFilled"] isEqual:[NSNull null]]) {
                    [user setIsProfileFilled:NO];
                }else {
                    [user setIsProfileFilled:[res[@"isProfileFilled"] boolValue]];
                }
                
                [[AppDelegate shared] setMe:user];
                [[[AppDelegate shared] me] save];
                
                [self showProfileVC];
            }else { // status -> error
                [self.errorLabel setHidden:NO];
                NSLog(@"%@", res[@"message"]);
            }

        }else {
            [self.errorLabel setHidden:NO];
//            [self showAlertWithTitle:@"" message:@"Something went wrong! Please try again later!"];
        }
    }];
}

- (IBAction)notReceivedTouchUp:(UIButton *)sender {
    sender.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);

    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)nextTouchDown:(UIButton *)sender {
    sender.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
}

- (IBAction)nextTouchUpOutside:(UIButton *)sender {
    sender.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
}

- (IBAction)notReceivedTouchDown:(UIButton *)sender {
    sender.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
}

- (IBAction)notReceivedTouchUpOutside:(UIButton *)sender {
    sender.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
}

#pragma mark - Public Methods

- (void)setPhoneNumber: (NSString *)sender {
    phoneNum = sender;
}

#pragma mark - Custom Methods

- (void)showProfileVC {
    ProfileViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showAlertWithTitle: (NSString *)title message: (NSString *)message {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okA = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertC addAction:okA];
    
    [self presentViewController:alertC animated:YES completion:nil];
}

- (void)dismissKeyboard {
    [self.view endEditing:YES];
}


@end
