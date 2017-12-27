//
//  HPUser.m
//  testAlert
//
//  Created by 曹均华 on 2017/12/26.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "HPUser.h"
#import "HPUserBuilder.h"

@interface HPUser()
@property (nonatomic,assign)BOOL frozen;

@end

@implementation HPUser
- (instancetype)initWithBuilder:(HPUserBuilder *)builder {
    if (self = [super init]) {
        self.userId = builder.userId;
        self.firstName = builder.firstName;
    }
    return self;
}
+ (instancetype)userWithBlock:(HPUserBuilderBlock)block {
    HPUserBuilder *builder = [[HPUserBuilder alloc] init];
    block(builder);
    return [builder build];
}
@end
