//
//  LCActionSheet.m
//  LCActionSheetViewController_Example
//
//  Created by manjiwang on 2019/5/28.
//  Copyright © 2019 jgyhc. All rights reserved.
//

#import "LCActionSheet.h"

@interface LCActionSheet ()


@end

@implementation LCActionSheet


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setBackgroundImage:[self createImageWithColor:[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0]] forState:UIControlStateHighlighted];
        [self setBackgroundImage:[self createImageWithColor:[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0]] forState:UIControlStateNormal];
        self.font = [UIFont systemFontOfSize:16];
        self.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        self.height = 44.0;
    }
    return self;
}


- (void)setTitle:(NSString *)title {
    _title = title;
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setFont:(UIFont *)font {
    _font = font;
    self.titleLabel.font = font;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    [self setTitleColor:_textColor forState:UIControlStateNormal];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _backgroundColor = backgroundColor;
    [self setBackgroundImage:[self createImageWithColor:_backgroundColor] forState:UIControlStateNormal];
}


- (UIImage*)createImageWithColor:(UIColor*)color {
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


@end
