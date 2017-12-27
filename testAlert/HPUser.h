//
//  HPUser.h
//  testAlert
//
//  Created by 曹均华 on 2017/12/26.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HPUserBuilder;
typedef void(^HPUserBuilderBlock)(HPUserBuilder *builder);
@interface HPUser : NSObject
@property (nonatomic,copy)NSString *userId;
@property (nonatomic,copy)NSString *firstName;

+ (instancetype)userWithBlock:(HPUserBuilderBlock)block;
- (instancetype)initWithBuilder:(HPUserBuilder *)builder;
@end
