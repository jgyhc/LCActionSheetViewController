//
//  LCActionSheet.h
//  LCActionSheetViewController_Example
//
//  Created by manjiwang on 2019/5/28.
//  Copyright © 2019 jgyhc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LCActionSheet : UIButton

@property (nonatomic, copy) NSString * title;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) UIColor * backgroundColor;

@property (nonatomic, strong) UIColor * textColor;

@property (nonatomic, strong) UIFont * font;

@end

NS_ASSUME_NONNULL_END
