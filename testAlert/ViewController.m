//
//  ViewController.m
//  testAlert
//
//  Created by 曹均华 on 2017/12/19.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import "ViewController.h"
#import "sampleUser.h"
#import "HPUser.h"

@interface ViewController ()
@property (nonatomic,strong)UITextField *textF1;
@property (nonatomic,strong)UITextField *textF2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    // 修改了
    [self allFont];
    [self addLabel];
}
- (void)addLabel {
    UITextField *textF1 = [[UITextField alloc] initWithFrame:CGRectMake(0, 20, 40, 20)];
    textF1.backgroundColor = [UIColor grayColor];
    _textF1 = textF1;
    [self.view addSubview:textF1];
    
    UITextField *textF2 = [[UITextField alloc] initWithFrame:CGRectMake(0, 50, 40, 20)];
    textF2.backgroundColor = [UIColor greenColor];
    _textF2 = textF2;
    [self.view addSubview:textF2];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 80, 40, 40)];
    btn.backgroundColor = [UIColor orangeColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)btnClick {
    sampleUser *sam = [[sampleUser alloc] init];
    HPUser *user = [sam createUser];
    _textF1.text = user.userId;
    _textF2.text = user.firstName;
}
- (void)allFont {
    NSArray * fontArrays = [[UIFont familyNames] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSString *str1 = (NSString *)obj1;
        NSString *str2 = (NSString *)obj2;
        return [str1 compare:str2];
    }];
    for(NSString *fontfamilyname in fontArrays)
    {
        NSLog(@"family:'%@'",fontfamilyname);
        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
        {
            NSLog(@"\tfont:'%@'",fontName);
        }
        NSLog(@"-------------");
    }
}

- (void)click {
    NSArray *arr = @[@1];
    NSLog(@"arr==%@",arr[2]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
