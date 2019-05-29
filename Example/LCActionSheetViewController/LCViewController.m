//
//  LCViewController.m
//  LCActionSheetViewController
//
//  Created by jgyhc on 05/28/2019.
//  Copyright (c) 2019 jgyhc. All rights reserved.
//

#import "LCViewController.h"
#import "LCActionSheetViewController.h"

@interface LCViewController ()

@end

@implementation LCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)show:(id)sender {
    
    LCActionSheetViewController *viewController = [[LCActionSheetViewController alloc] initWithTitles:@[@"确定", @"asdalsk", @"阿达的快乐", @"按时打卡了敬爱空间的"] handler:^(LCActionSheet * _Nonnull actionSheet, NSString * _Nonnull title, NSInteger idex) {
        NSLog(@"点击了%@", title);
    }];
    [self presentViewController:viewController animated:YES completion:nil];
    
}

@end
