//
//  BindCell.m
//  1111111111111111
//
//  Created by 雨 on 16/11/11.
//  Copyright © 2016年 RYT. All rights reserved.
//

#import "BindCell.h"
#import "Masonry.h"
#import "BindModel.h"

@interface BindCell ()

@property (nonatomic, strong) UIButton *domainButton;     //省的简称按钮
@property (nonatomic, strong) UIButton *pullDownButton;   //简称后面的箭头图片按钮
@property (nonatomic, strong) UITextField *textField;     //输入框
@property (nonatomic, strong) UIButton *selectButton;     //输入框后面的选中  取消按钮
@property (nonatomic, strong) BindModel *bindModel;

@end
@implementation BindCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor cyanColor];
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor redColor].CGColor;
        [self initUI];
        [self setLayouts];
    }
    return self;
}

- (void)initUI {
    [self.contentView addSubview:self.domainButton];
    [self.contentView addSubview:self.pullDownButton];
    [self.contentView addSubview:self.textField];
    [self.contentView addSubview:self.selectButton];
}

- (void)setLayouts {
    __weak typeof(self)weakSelf = self;
    [_domainButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).with.offset(20);
        make.top.and.bottom.equalTo(weakSelf.contentView);
        make.width.mas_equalTo(@24);
    }];
    [_pullDownButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.domainButton.mas_right).with.offset(5);
        make.top.and.bottom.equalTo(weakSelf.contentView);
        make.width.mas_equalTo(@16);
    }];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.pullDownButton.mas_right).with.offset(5);
        make.top.and.bottom.equalTo(weakSelf.contentView);
        make.right.equalTo(weakSelf.contentView).with.offset(-10);
    }];
    [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.contentView).with.offset(-10);
        make.top.and.bottom.equalTo(weakSelf.contentView);
        make.width.mas_equalTo(@24);
    }];
}

#pragma mark - out

- (void)configCellWith:(BindModel *)model {
    _bindModel = model;
    __weak typeof(self)weakSelf = self;

    [_domainButton setTitle:model.domain forState:UIControlStateNormal];
    _textField.text = model.carNumber;
    if (model.isBind) {
        [_textField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.contentView).with.offset(-44);
        }];
        _selectButton.hidden = NO;
        _textField.userInteractionEnabled = NO;
        _domainButton.enabled = NO;
    } else {
        [_textField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.contentView).with.offset(-10);
        }];
        _selectButton.hidden = YES;
        _textField.userInteractionEnabled = YES;
        _domainButton.enabled = YES;
    }
    [_selectButton setImage:[UIImage imageNamed:model.isSelected?@"binding_pulldown":@"chooseBtn"] forState:UIControlStateNormal];

}

#pragma mark - private

- (void)buttonClickEvent:(UIButton *)sender {
    if ([sender isEqual:_domainButton]) {
        if (self.event) {
            self.event(0,_bindModel);
        }
    } else if ([sender isEqual:_selectButton]) {
        if (self.event) {
            self.event(1,_bindModel);
        }
    }
}

- (void)editChanged:(UITextField *)textField {
    if ([textField isEqual:_textField]) {
        if (self.changed) {
            self.changed(textField.text);
        }
    }
}

#pragma mark - property

- (UIButton *)domainButton {
    if (_domainButton == nil) {
        _domainButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_domainButton setTitle:@"苏" forState:UIControlStateNormal];
        [_domainButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_domainButton addTarget:self action:@selector(buttonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _domainButton;
}

- (UIButton *)pullDownButton {
    if (_pullDownButton == nil) {
        _pullDownButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pullDownButton setImage:[UIImage imageNamed:@"binding_pulldown"] forState:UIControlStateNormal];
    }
    return _pullDownButton;
}

- (UITextField *)textField {
    if (_textField == nil) {
        _textField = [[UITextField alloc]init];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.placeholder = @"请输入车牌号";
        [_textField addTarget:self action:@selector(editChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

- (UIButton *)selectButton {
    if (_selectButton == nil) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton setImage:[UIImage imageNamed:@"chooseBtn"] forState:UIControlStateNormal];
        [_selectButton addTarget:self action:@selector(buttonClickEvent:) forControlEvents:UIControlEventTouchUpInside];
        _selectButton.hidden = YES;
    }
    return _selectButton;
}

@end
