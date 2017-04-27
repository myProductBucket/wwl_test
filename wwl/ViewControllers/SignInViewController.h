//
//  SignInViewController.h
//  8a-ios
//
//  Created by Mobile on 21/04/2017.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CountryPicker/CountryPicker.h>

@interface SignInViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (weak, nonatomic) IBOutlet UITextField *countryCodeTF;
@property (weak, nonatomic) IBOutlet UIButton *getConfirmCodeButton;
@property (retain, nonatomic) IBOutlet CountryPicker *countryPickerC;


// -- Constraints

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *phoneNumberViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *getConfirmCodeWidthConstraint;


@end
