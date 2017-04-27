//
//  UIView+Extension.m
//  wwl
//
//  Created by Mobile on 26/04/2017.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)shadowForButton {
    self.layer.cornerRadius = 4.0f;
    self.layer.masksToBounds = NO;
    self.layer.borderWidth = 1.0f;
    
    self.layer.shadowOpacity = 0.65;
    self.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowRadius = 2.0;
}

@end
