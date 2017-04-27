//
//  BaseService.h
//  8a-ios
//
//  Created by Mobile on 21/04/2017.
//  Copyright © 2017 Allfree Group LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "APIConfig.h"

@interface BaseService : NSObject

+(BaseService *)shared;

- (void)requestGetWithURL:(NSString *)url atPath:(NSString *)path withParams:(NSDictionary *)params token: (NSString *)token withResponse:(void(^)(BOOL success,id res))block;
- (void)requestGetWithURL:(NSString *)url atPath:(NSString *)path withParams:(NSDictionary *)params withResponse:(void(^)(BOOL success,id res))block;
- (void)requestPostWithURL:(NSString *)url atPath:(NSString *)path withParams:(NSDictionary *)params withResponse:(void(^)(BOOL success,id res))block;
- (void)requestDeleteWithURL:(NSString *)url atPath:(NSString *)path withParams:(NSDictionary *)params withResponse:(void(^)(BOOL success,id res))block;
- (void)requestPutWithURL:(NSString *)url atPath:(NSString *)path withParams:(NSDictionary *)params  withResponse:(void(^)(BOOL success,id res))block;

@end
