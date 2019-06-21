//
//  LCActionSheetViewController.h
//  LCActionSheetViewController_Example
//
//  Created by manjiwang on 2019/5/28.
//  Copyright © 2019 jgyhc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCActionSheet.h"

NS_ASSUME_NONNULL_BEGIN

@interface LCActionSheetViewController : UIViewController

+ (instancetype)initWithTitles:(NSArray <NSString *>*)titles handler:(void (^) (LCActionSheet *actionSheet, NSString *title, NSInteger idex))handler;

- (instancetype)initWithActionSheets:(NSArray <LCActionSheet *>*)actions handler:(void (^) (LCActionSheet *actionSheet, NSString *title, NSInteger idex))handler;

@end

NS_ASSUME_NONNULL_END
