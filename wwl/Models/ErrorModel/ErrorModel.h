//
//  ErrorModel.h
//  wwl
//
//  Created by Mobile on 27/04/2017.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ErrorModel : NSObject

@property (strong, nonatomic) NSString *errorKey;
@property (strong, nonatomic) NSString *field;
@property (strong, nonatomic) NSString *message;

- (id)initWith: (NSDictionary *)dic;

@end
