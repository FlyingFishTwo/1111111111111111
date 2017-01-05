//
//  BindFooterReusableView.m
//  1111111111111111
//
//  Created by 雨 on 16/11/11.
//  Copyright © 2016年 RYT. All rights reserved.
//

#import "BindFooterReusableView.h"
#import "Masonry.h"

@interface BindFooterReusableView ()

@property (nonatomic, assign) BOOL mode;
@property (nonatomic, strong) UIButton *addButton;    //增加按钮
@property (nonatomic, strong) UIButton *unBindButton; //解除绑定按钮

@end
@implementation BindFooterReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        [self setLayouts];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.addButton];
    [self addSubview:self.unBindButton];
}

- (void)setLayouts {
    __weak typeof(self)weakSelf = self;
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf).with.offset(17);
        make.right.equalTo(weakSelf).with.offset(-17);
        make.height.mas_equalTo(@40);
    }];
    [_unBindButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.addButton.mas_bottom).with.offset(20);
        make.centerX.equalTo(weakSelf);
        make.width.equalTo(weakSelf.addButton);
        make.height.greaterThanOrEqualTo(@0);
    }];
}

#pragma mark - out

- (void)configAddMode:(BOOL)mode {
    _mode = mode;
    _unBindButton.hidden = !mode;
    if (mode) {
        [_addButton setTitle:@"新增" forState:UIControlStateNormal];
    } else {
        [_addButton setTitle:@"确定" forState:UIControlStateNormal];
    }
}

#pragma mark - private

- (void)buttonClickEvent:(UIButton *)sender {
    if ([sender isEqual:_addButton]) {
        if (self.event) {
            self.event(0,_mode);
        }
    } else if ([sender isEqual:_unBindButton]) {
        if (self.event) {
            self.event(1,_mode);
        }
    }
}

#pragma mark - property

- (UIButton *)addButton {
    if (_addButton == nil) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton addTarget:self action:@selector(buttonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_addButton setTitle:@"确定" forState:UIControlStateNormal];
        [_addButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _addButton.backgroundColor = [UIColor blackColor];
    }
    return _addButton;
}

- (UIButton *)unBindButton {
    if (_unBindButton == nil) {
        _unBindButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_unBindButton addTarget:self action:@selector(buttonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
        [_unBindButton setTitle:@"解除绑定" forState:UIControlStateNormal];
        [_unBindButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _unBindButton.backgroundColor = [UIColor blackColor];

        _unBindButton.hidden = YES;
    }
    return _unBindButton;
}

@end
