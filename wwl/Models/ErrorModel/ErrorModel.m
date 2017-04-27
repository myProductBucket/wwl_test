//
//  ErrorModel.m
//  wwl
//
//  Created by Mobile on 27/04/2017.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#import "ErrorModel.h"

@implementation ErrorModel

- (id)initWith: (NSDictionary *)dic {
    self = [super init];
    
    self.errorKey = (dic[@"error_key"] == nil || [dic[@"error_key"] isEqual:[NSNull null]])?nil: dic[@"error_key"];
    self.field = (dic[@"field"] == nil || [dic[@"field"] isEqual:[NSNull null]])?nil: dic[@"field"];
    self.message = (dic[@"message"] == nil || [dic[@"message"] isEqual:[NSNull null]])?nil: dic[@"message"];
    
    return self;
}

@end
