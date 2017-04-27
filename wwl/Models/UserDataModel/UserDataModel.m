//
//  UserDataModel.m
//  8a-ios
//
//  Created by Mobile on 24/04/2017.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#import "UserDataModel.h"

@implementation UserDataModel

- (id)initWith: (NSDictionary *)dic {
    self = [super init];
    
    self.fieldID = ([dic[@"id"] isEqual:[NSNull null]] || dic[@"id"] == nil)? nil: dic[@"id"];
    self.fieldName = ([dic[@"field_name"] isEqual:[NSNull null]] || dic[@"field_name"] == nil)? nil: dic[@"field_name"];
    self.isRequired = dic[@"is_required"]? [dic[@"is_required"] boolValue]: NO;
    self.isValid = dic[@"is_valid"]? [dic[@"is_valid"] boolValue]: NO;
    self.label = ([dic[@"label"] isEqual:[NSNull null]] || dic[@"label"] == nil)? nil: dic[@"label"];
    self.fieldType = ([dic[@"field_type"] isEqual:[NSNull null]] || dic[@"field_type"] == nil)? TEXT: [self fieldTypeFromString:dic[@"field_type"]];
    
    if (self.fieldType == TEXT || self.fieldType == TEXT_AREA) {
        self.valueStr = ([dic[@"value"] isEqual:[NSNull null]] || dic[@"value"] == nil)? nil: dic[@"value"];
    }else if (self.fieldType == IMAGE) {
        self.valueImg = ([dic[@"value"] isEqual:[NSNull null]] || dic[@"value"] == nil)? nil: [UIImage imageWithData:dic[@"value"]];
    }else {
        
    }
    
    self.errorsArr = [[NSMutableArray alloc] init];
    if (dic[@"errors"] && ![dic[@"errors"] isEqual:[NSNull null]] && [dic[@"errors"] isKindOfClass:[NSArray class]]){
        for (NSDictionary *item in dic[@"errors"]) {
            ErrorModel *model = [[ErrorModel alloc] initWith:item];
            [self.errorsArr addObject:model];
        }
    }
    
    return self;
}

- (Field_Type)fieldTypeFromString: (NSString *)string {
    
    if ([string isEqualToString:@"text"]) {
        return TEXT;
    }else if ([string isEqualToString:@"textarea"]) {
        return TEXT_AREA;
    }else if ([string isEqualToString:@"image"]) {
        return IMAGE;
    }
    return TEXT;
}

@end
