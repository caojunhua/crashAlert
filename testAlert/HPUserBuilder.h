//
//  HPUserBuilder.h
//  testAlert
//
//  Created by 曹均华 on 2017/12/26.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HPUser;
@interface HPUserBuilder : NSObject

@property (nonatomic,copy)NSString *userId;
@property (nonatomic,copy)NSString *firstName;
- (HPUser *)build;
@end
