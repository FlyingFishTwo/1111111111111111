//
//  MarkView.m
//  TheatreJS
//
//  Created by li on 16/11/9.
//  Copyright © 2016年 RYT. All rights reserved.
//
#import "MarkView.h"
#import "UIColor+AddColor.h"
#import "UIView+Extension.h"
#define WeakSelf(weakSelf) __weak typeof(&*self)weakSelf = self
#define BXScreenH          [UIScreen mainScreen].bounds.size.height
#define BXScreenW          [UIScreen mainScreen].bounds.size.width
#define ButtonNormal       UIControlStateNormal


@interface MarkView()
{
    UIImageView *_BJView;
    //左边退出按钮
    UIButton *cancelButton;
    //右边的确定按钮
    UIButton *chooseButton;
    NSMutableArray *dataArray;
    
}
@property(nonatomic,strong)NSString *dataString;
@property(nonatomic,strong)UIButton *lastBtn;

@end
@implementation MarkView

- (id)initWithFrame:(CGRect)frame withClassArray:(NSArray *)classArray{
    if (self = [super initWithFrame:frame]) {
        [UIView animateWithDuration:0.3 animations:^{
            self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        }];
        dataArray = [NSMutableArray array];
        _BJView = [[UIImageView alloc] initWithFrame:CGRectMake(0, BXScreenH, BXScreenW, 260)];
        _BJView.userInteractionEnabled = YES;
        _BJView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_BJView];
        
        //盛放按钮的View
        UIView *toolView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BXScreenW, 40)];
        toolView.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
        toolView.userInteractionEnabled = YES;
        [_BJView addSubview:toolView];
        
        
        //左边的取消按钮
        cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(12, 0, 40, 40);
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        cancelButton.backgroundColor = [UIColor clearColor];
        [cancelButton setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [cancelButton addTarget:self action:@selector(hiddenMarkView) forControlEvents:UIControlEventTouchUpInside];
        [toolView addSubview:cancelButton];
        
        //右边的确定按钮
        chooseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        chooseButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 50, 0, 40, 40);
        [chooseButton setTitle:@"完成" forState:UIControlStateNormal];
        chooseButton.backgroundColor = [UIColor clearColor];
        [chooseButton setTitleColor:[UIColor colorWithHexString:@"#ff4545"] forState:UIControlStateNormal];
        chooseButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [chooseButton addTarget:self action:@selector(hiddenMarkViewRight) forControlEvents:UIControlEventTouchUpInside];
        [toolView addSubview:chooseButton];
        
        cusView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 40, BXScreenW, 260 - 40)];
        cusView.backgroundColor = [UIColor whiteColor];
        cusView.userInteractionEnabled = YES;
        [_BJView addSubview:cusView];
        
    
        for (int i = 0; i < classArray.count; i++) {
            _markBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _markBtn.frame = CGRectMake(15+40*(i%9) ,34 + 44*(i/9),25, 25);
            _markBtn.backgroundColor = [UIColor whiteColor];
            [_markBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
            _markBtn.titleLabel.font = [UIFont systemFontOfSize:10];
            _markBtn.layer.borderWidth = 1;
            _markBtn.layer.borderColor = [UIColor colorWithHexString:@"#c4c4c4"].CGColor;
            [_markBtn addTarget:self action:@selector(markClick:) forControlEvents:UIControlEventTouchUpInside];
            _markBtn.tag = 100+i;
            [cusView addSubview:_markBtn];
            [_markBtn setTitle:classArray[i] forState:UIControlStateNormal];
        }
        
    }
    return self;
}


-(void)markClick:(UIButton *)btn{
    _lastBtn.backgroundColor = [UIColor whiteColor];
    [_lastBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithHexString:@"#292929"];
    
    
    self.lastBtn = btn;
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self];
    if (!CGRectContainsPoint(_BJView.frame, point)) {
        [self hiddenMarkView];
    }
}
-(void)hiddenMarkView{
    [UIView animateWithDuration:0.3f animations:^{
        _BJView.frame = CGRectMake(0, BXScreenH, BXScreenW, 260);
        self.alpha = 0.1;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    NSLog(@"hiddenMarkView");
}
-(void)hiddenMarkViewRight{
    [UIView animateWithDuration:0.3f animations:^{
        _BJView.frame = CGRectMake(0, BXScreenH, BXScreenW, 260);
        self.alpha = 0.1;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    //    for (int i = 0; i<dataArray.count; i++) {
    //        self.dataString = [dataArray componentsJoinedByString:@","];
    //    }
    self.dataString = _lastBtn.currentTitle;
    
    if ([self.delegate respondsToSelector:@selector(didFinishMarkView:)]) {
        [self.delegate didFinishMarkView:_lastBtn.currentTitle];
    }


}
#pragma mark -- show and hidden
- (void)showInView:(UIView *)view{
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    [UIView animateWithDuration:0.3f animations:^{
        _BJView.frame = CGRectMake(0, BXScreenH - 260, BXScreenW, 260);
    } completion:^(BOOL finished) {
    }];
}
@end
