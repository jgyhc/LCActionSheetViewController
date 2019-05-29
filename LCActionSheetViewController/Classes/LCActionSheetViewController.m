//
//  LCActionSheetViewController.m
//  LCActionSheetViewController_Example
//
//  Created by manjiwang on 2019/5/28.
//  Copyright © 2019 jgyhc. All rights reserved.
//

#import "LCActionSheetViewController.h"
#import "Masonry.h"

@interface LCActionSheetViewController ()
@property (nonatomic, strong) UIControl *backgroundView;

@property (nonatomic, strong) UIView * containerView;

@property (nonatomic, strong) NSArray<LCActionSheet *> * actions;

@property (nonatomic, strong) LCActionSheet *cancelActionSheet;

@property (nonatomic, assign) CGFloat containerHeight;

@property (nonatomic, copy) void (^handleBlock)(LCActionSheet *actionSheet, NSString *title, NSInteger idex);
@end

@implementation LCActionSheetViewController

- (instancetype)initWithTitles:(NSArray <NSString *>*)titles handler:(void (^) (LCActionSheet *actionSheet, NSString *title, NSInteger idex))handler {
    NSMutableArray *objs = [NSMutableArray array];
    [titles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        LCActionSheet *actionSheet = [[LCActionSheet alloc] init];
        actionSheet.title = obj;
        [objs addObject:actionSheet];
    }];
    return [[LCActionSheetViewController alloc] initWithActionSheets:objs handler:handler];
}

- (instancetype)initWithActionSheets:(NSArray <LCActionSheet *>*)actions handler:(void (^) (LCActionSheet *actionSheet, NSString *title, NSInteger idex))handler
{
    self = [super init];
    if (self) {
        self.handleBlock = handler;
        self.actions = actions;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    }
    return self;
}

- (void)setActions:(NSArray<LCActionSheet *> *)actions {
    _actions = actions;
    
    [self.containerView addSubview:self.cancelActionSheet];
    
    [self.cancelActionSheet mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.containerView.mas_left).mas_offset(10);
        make.right.mas_equalTo(self.containerView.mas_right).mas_offset(-10);
        make.height.mas_equalTo(44.0);
        make.bottom.mas_equalTo(self.containerView.mas_bottom).mas_offset(-[self bottomSpace]);
    }];
    
    UIView *contentView = [UIView new];
    contentView.layer.cornerRadius = [self containerCircular];
    contentView.clipsToBounds = YES;
    [self.containerView addSubview:contentView];
    __block CGFloat bottomSpace = 0;
    [_actions enumerateObjectsUsingBlock:^(LCActionSheet * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.tag = 1000 + idx;
        [obj addTarget:self action:@selector(handleActionEvent:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(contentView.mas_bottom).mas_offset(-bottomSpace);
            make.height.mas_equalTo(obj.height);
            make.left.mas_equalTo(contentView.mas_left);
            make.right.mas_equalTo(contentView.mas_right);
        }];
        bottomSpace = bottomSpace + obj.height;
        if (idx != 0) {
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = [UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1.0];
            [self.containerView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(obj.mas_bottom);
                make.height.mas_equalTo(0.6);
                make.left.mas_equalTo(contentView.mas_left);
                make.right.mas_equalTo(contentView.mas_right);
            }];
        }
    }];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.containerView.mas_left).mas_offset(10);
        make.right.mas_equalTo(self.containerView.mas_right).mas_offset(-10);
        make.bottom.mas_equalTo(self.cancelActionSheet.mas_top).mas_offset(-10);
        make.height.mas_equalTo(bottomSpace);
    }];
    _containerHeight = bottomSpace + [self bottomSpace] + 44.0 + 10;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
    
    if (![self isModal]) {
        [self.view addSubview:self.backgroundView];
        [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    [self.view addSubview:self.containerView];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(_containerHeight);
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.height.mas_equalTo(_containerHeight);
    }];
    [self.view layoutIfNeeded];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self show];
}

- (void)handleActionEvent:(LCActionSheet *)sender {
    NSInteger idx = sender.tag - 1000;
    if (self.handleBlock) {
        self.handleBlock(sender, sender.title, idx);
    }
    [self hide];
}

- (BOOL)isModal {
    return NO;
}

- (CGFloat)containerCircular {
    return 10.0;
}

- (CGFloat)bottomSpace {
    if (@available(iOS 11.0, *)) {
        UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
        // 获取底部安全区域高度，iPhone X 竖屏下为 34.0，横屏下为 21.0，其他类型设备都为 0
        CGFloat bottomSafeInset = keyWindow.safeAreaInsets.bottom;
        return bottomSafeInset;
    }
    return 0;
}

- (void)show {
    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)hide {
    [self.containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).mas_offset(_containerHeight);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}



- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor clearColor];
        _containerView.layer.cornerRadius = [self containerCircular];
    }
    return _containerView;
}

- (UIControl *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIControl alloc] init];
        [_backgroundView addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backgroundView;
}

- (LCActionSheet *)cancelActionSheet {
    if (!_cancelActionSheet) {
        _cancelActionSheet = [[LCActionSheet alloc] init];
        _cancelActionSheet.title = @"取消";
        [_cancelActionSheet addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        _cancelActionSheet.layer.cornerRadius = [self containerCircular];
        _cancelActionSheet.clipsToBounds = YES;
    }
    return _cancelActionSheet;
}

@end

