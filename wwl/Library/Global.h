//
//  Global.h
//  8a-ios
//
//  Created by Mobile on 24/04/2017.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#ifndef Global_h
#define Global_h

#define CURRENT_USER @"current user"
#define APP_NAME @"WWL"

#define nWidth ([[UIScreen mainScreen] bounds].size.width > [[UIScreen mainScreen] bounds].size.height ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)
#define nHeight ([[UIScreen mainScreen] bounds].size.width < [[UIScreen mainScreen] bounds].size.height ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

#define IPHONE UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone
#define IPAD   UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad

#endif /* Global_h */
