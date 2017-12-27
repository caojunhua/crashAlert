//
//  sampleUser.m
//  testAlert
//
//  Created by 曹均华 on 2017/12/26.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "sampleUser.h"
#import "HPUser.h"
#import "HPUserBuilder.h"

@implementation sampleUser

- (HPUser *)createUser {
    HPUser *rv = [HPUser userWithBlock:^(HPUserBuilder *builder) {
        builder.userId = @"id--1";
        builder.firstName = @"Alice";
    }];
    return rv;
}
@end
