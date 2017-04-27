//
//  SignInViewController.m
//  8a-ios
//
//  Created by Mobile on 21/04/2017.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#import "SignInViewController.h"
#import "ConfirmCodeViewController.h"

@interface SignInViewController () <CountryPickerDelegate, UITextFieldDelegate> {
    NSString *countryCodeAlpha2; // "US"
    NSString *countryCodeNumeric; // "1"
    BOOL isCountryCode; //
}

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(phoneNumberDidChange:) name:UITextFieldTextDidChangeNotification object:self.phoneNumTF];
    
    [self initUI];
    
    // Navigation Bar
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setTitle:APP_NAME];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self setTitle:@""];
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)initUI  {
    [self.getConfirmCodeButton shadowForButton];
    
    [self.phoneNumberViewHeightConstraint setConstant:nHeight * 50.0 / 667.0];
    [self.getConfirmCodeWidthConstraint setConstant:nWidth * 250 / 375.0];
    
    // Country Code Input View
    self.countryPickerC = [[CountryPicker alloc] init];
    [self.countryPickerC setDelegate:self];
    [self.countryCodeTF setInputView:self.countryPickerC];
    
    UIToolbar *accessoryView = [[UIToolbar alloc] init];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:nil action:@selector(dismissKeyboard)];
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [accessoryView sizeToFit];
    [accessoryView setItems:[NSArray arrayWithObjects: flexSpace,doneButton, nil]];
    [self.phoneNumTF setInputAccessoryView:accessoryView];
    [self.countryCodeTF setInputAccessoryView:accessoryView];
    
    isCountryCode = YES;
    
}

#pragma mark - UIPickerViewDelegate (CountryCodePicker)

- (void)countryPicker:(CountryPicker *)picker didSelectCountryWithName:(NSString *)name code:(NSString *)code {
    countryCodeAlpha2 = code;
    
    NBPhoneNumberUtil *phoneUtil = [[NBPhoneNumberUtil alloc] init];
    NSError *error;
    NBPhoneNumber *phoneNumber = [phoneUtil parse:@"123" defaultRegion:code error:&error];
    NSLog(@"CountryCode: %@", code);
    NSLog(@"Error: %@", error.localizedDescription);
    NSLog(@"Prefix: %@", phoneNumber.countryCode);
    countryCodeNumeric = [phoneNumber.countryCode stringValue];
    [self.countryCodeTF setText:[NSString stringWithFormat:@"+%@", countryCodeNumeric]];
    isCountryCode = NO;
    
//    NBAsYouTypeFormatter *f = [[NBAsYouTypeFormatter alloc] initWithRegionCode:@"US"];
//    NSLog(@"%@", [f inputString:@"1234 56 7 8900"]);
}

#pragma mark - UITextFieldDelegate

- (void)phoneNumberDidChange: (NSNotification *)sender {
    NSString *str = self.phoneNumTF.text;
    NSString *trimmed = [[str componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
    
    NBAsYouTypeFormatter *f = [[NBAsYouTypeFormatter alloc] initWithRegionCode:countryCodeAlpha2];
    
    NSString *formattedNumber = [f inputString:trimmed];
    if ([f isSuccessfulFormatting]) {
        [self.phoneNumTF setText:formattedNumber];
    }else {
        [self.phoneNumTF setText:[f removeLastDigit]];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSCharacterSet *notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ([string rangeOfCharacterFromSet:notDigits].location == NSNotFound) {
        NSLog(@"%@", [textField text]);
        return YES;
    }
    return NO;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    NSLog(@"%@", [textField text]);
    return YES;
}

#pragma mark - UIButon Actions

- (IBAction)getConfirmationCodeTouchUp:(UIButton *)sender {
    sender.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    
    // Checking valid phone number
    
    NSString *phoneNum = [self.phoneNumTF text];
    NSString *trimmed = [[phoneNum componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
    
    NBAsYouTypeFormatter *f = [[NBAsYouTypeFormatter alloc] initWithRegionCode:countryCodeAlpha2];
    
    NSString *formattedNumber = [f inputString:trimmed];
    NSLog(@"Formatted Number: %@", formattedNumber);
    
    if (countryCodeNumeric == nil || phoneNum == nil || [phoneNum length] < 5 || ![f isSuccessfulFormatting]) {
        [self showAlertWithTitle:@"" message:@"Please input the valid phone number"];
        return;
    }
    
    phoneNum = [NSString stringWithFormat:@"+%@%@", countryCodeNumeric, trimmed];
    NSLog(@"Phone Number: %@", phoneNum);
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[MyService shared] requestConfirmationCodeWithPhoneNum:phoneNum withCompletion:^(BOOL success, id res) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

        if (success) {
            if ([res[@"status"] isEqualToString:@"ok"]) {
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"Success" message:res[@"message"] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okA = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self showConfirmCodeVC:phoneNum];
                }];
                
                [alertC addAction:okA];
                
                [self presentViewController:alertC animated:YES completion:^{

                }];
            }else if ([res[@"status"] isEqualToString:@"error"]) {
                [self showAlertWithTitle:@"" message:res[@"message"]];
            }
        }else {
            NSLog(@"%@", [res localizedDescription]);
            [self showAlertWithTitle:@"" message:@"Something went wrong. Please try again later!"];
        }
    }];
}

- (IBAction)getConfirmCodeTouchDown:(UIButton *)sender {
    sender.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    [self.view endEditing:YES];
}

- (IBAction)getConfirmCodeTouchUpOutside:(UIButton *)sender {
    sender.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
}


#pragma mark - Custom Methods

- (void)showConfirmCodeVC: (NSString *)phoneNum {
    ConfirmCodeViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ConfirmCodeViewController"];
    [vc setPhoneNumber:phoneNum];
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
