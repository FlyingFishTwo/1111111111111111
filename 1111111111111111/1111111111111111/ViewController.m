//
//  NoLicensePlateViewController.m
//  TheatreJS
//
//  Created by li on 16/11/9.
//  Copyright © 2016年 RYT. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+AddColor.h"
#import "Masonry.h"
#import "UIView+Extension.h"
#import "MarkView.h"
#define WeakSelf(weakSelf) __weak typeof(&*self)weakSelf = self
#define BXScreenH          [UIScreen mainScreen].bounds.size.height
#define BXScreenW          [UIScreen mainScreen].bounds.size.width
#define ButtonNormal       UIControlStateNormal


@interface ViewController ()<UITextFieldDelegate,MarkViewDelegate>{
    MarkView *markView;
}
@property (nonatomic,strong) UITextField         *boundingTF;
@property (nonatomic,strong) UIButton            *abbreviaBtn;//简称按钮
@property (nonatomic,strong) UIButton            *sureBtn;//确定按钮
@property (nonatomic,strong) NSMutableArray            *classArray;//确定按钮
@property(nonatomic,strong)UIButton *lastBtn;
@property (nonatomic,strong) UIButton            *chooseBtn;//选择按钮   还没添加

@end

@implementation ViewController
- (void)loadView {
    [super loadView];
    UIView *view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor colorWithHexString:@"#f9f9f9"];
    self.view = view;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定";
    [self.view addSubview:self.boundingTF];
    [self.view addSubview:self.abbreviaBtn];
    [self.view addSubview:self.sureBtn];
    
    self.classArray = [NSMutableArray arrayWithObjects:@"京",@"津",@"沪",@"渝",@"冀",@"豫",@"云",@"辽",@"黑",@"湘",@"皖",@"鲁",@"新",@"苏",@"浙",@"赣",@"鄂",@"桂",@"甘",@"晋",@"陕",@"吉",@"闽",@"贵",@"粤",@"青",@"藏",@"川",@"宁",@"琼",@"台", nil];
    
    
}

- (void)chooseAbbreviaEvent:(UIButton*)event{
    markView = [[MarkView alloc]initWithFrame:CGRectMake(0, 0, BXScreenW, BXScreenH) withClassArray:_classArray];
    markView.delegate = self;
    [markView showInView:self.view];
//    [event setTitle:_classArray[event.tag] forState:ButtonNormal];

}

- (void)didFinishMarkView:(NSString *)date{
    NSLog(@"点击完成的代理方法");
    //点击完成    选中的按钮的title就是  输入框前面按钮的title
    [_abbreviaBtn setTitle:date forState:ButtonNormal];

    

}

- (void)buttonClick:(UIButton*)event{
    NSLog(@"确定");
    if (_boundingTF.text.length == 0) {
        NSLog(@"请输入您的车牌号");
        return;
    }
    else{
        //如果绑定成功     弹框提示    请求
        NSLog(@"绑定成功");
        [_sureBtn setTitle:@"新增" forState:ButtonNormal];
        _boundingTF.clearButtonMode = UITextFieldViewModeNever;

        
    }

}

- (void)chooseButtonClick:(UIButton*)event{
    
    
}

- (UIButton*)chooseBtn{
    if (!_chooseBtn) {
        _chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame = CGRectMake(_boundingTF.width-22, 14, 22, 22);
        _sureBtn.backgroundColor = [UIColor redColor];
        [_sureBtn addTarget:self action:@selector(chooseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
    
}

- (UIButton*)sureBtn{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [_sureBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:ButtonNormal];
        [_sureBtn setTitle:@"确定" forState:ButtonNormal];
        _sureBtn.frame = CGRectMake(15, _boundingTF.bottom+70, BXScreenW-30, 40);
        _sureBtn.backgroundColor = [UIColor colorWithHexString:@"#333333"];
        [_sureBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
    
}

- (UIButton*)abbreviaBtn{
    
    if (!_abbreviaBtn) {
        _abbreviaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _abbreviaBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [_abbreviaBtn setTitleColor:[UIColor blackColor] forState:ButtonNormal];
        [_abbreviaBtn setTitle:@"苏" forState:ButtonNormal];
        [_abbreviaBtn setImage:[UIImage imageNamed:@"binding_pulldown"] forState:ButtonNormal];
        [_abbreviaBtn setTitleEdgeInsets:UIEdgeInsetsMake(0 , -15, 0, 15)];
        [_abbreviaBtn setImageEdgeInsets:UIEdgeInsetsMake(0 , 20, 0, -15)];
        _abbreviaBtn.frame = CGRectMake(_boundingTF.left+15, _boundingTF.top, 40, _boundingTF.height);
        [_abbreviaBtn addTarget:self action:@selector(chooseAbbreviaEvent:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _abbreviaBtn;
    
}
- (UITextField*)boundingTF{
    if (!_boundingTF) {
        _boundingTF = [[UITextField alloc]initWithFrame:CGRectMake(15, 100, BXScreenW-30, 40)];
        _boundingTF.layer.borderColor = [[UIColor colorWithHexString:@"#e3e3e3"] CGColor];
        [_boundingTF setBorderStyle:UITextBorderStyleLine];
        _boundingTF.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        _boundingTF.layer.borderWidth = 1.0;
        _boundingTF.placeholder = @"请输入车牌号";
        _boundingTF.font = [UIFont systemFontOfSize:14.0f];
        _boundingTF.textColor = [UIColor colorWithHexString:@"#333333"];
        _boundingTF.clearButtonMode = UITextFieldViewModeAlways;
        _boundingTF.textAlignment = NSTextAlignmentLeft;
        _boundingTF.delegate = self;
        
    
        _boundingTF.clearButtonMode = UITextFieldViewModeAlways;
        
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 55, 5)];
        _boundingTF.leftView = view;
        _boundingTF.leftViewMode = UITextFieldViewModeAlways;
        _boundingTF.userInteractionEnabled = YES;
        
    }
    return _boundingTF;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
