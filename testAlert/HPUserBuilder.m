//
//  HPUserBuilder.m
//  testAlert
//
//  Created by 曹均华 on 2017/12/26.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "HPUserBuilder.h"
#import "HPUser.h"

@implementation HPUserBuilder
- (HPUser *)build {
    return [[HPUser alloc] initWithBuilder:self];
}

@end
