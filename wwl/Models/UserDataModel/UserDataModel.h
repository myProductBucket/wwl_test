//
//  UserDataModel.h
//  8a-ios
//
//  Created by Mobile on 24/04/2017.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ErrorModel.h"

typedef enum : NSUInteger {
    TEXT,
    TEXT_AREA,
    IMAGE,
} Field_Type;

@interface UserDataModel : NSObject

- (id)initWith: (NSDictionary *)dic;

@property (strong, nonatomic) NSString *fieldID;
@property (strong, nonatomic) NSString *fieldName;
@property Field_Type fieldType;
@property BOOL isRequired;
@property BOOL isValid;
@property (strong, nonatomic) NSString *label;
@property (strong, nonatomic) NSString *valueStr;
@property (strong, nonatomic) UIImage *valueImg;
@property (strong, nonatomic) NSMutableArray *errorsArr;

@end
