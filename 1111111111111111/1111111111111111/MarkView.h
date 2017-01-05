//
//  MarkView.h
//  TheatreJS
//
//  Created by li on 16/11/9.
//  Copyright © 2016年 RYT. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MarkViewDelegate <NSObject>

-(void)didFinishMarkView:(NSString*)date;

@end



@interface MarkView : UIView
{
    UIImageView *cusView;
}
@property(nonatomic,weak)id<MarkViewDelegate>delegate;

@property (copy, nonatomic) void (^sele)(NSString *markString);
@property (nonatomic,strong) UIButton *markBtn;

- (id)initWithFrame:(CGRect)frame withClassArray:(NSArray *)classArray;

- (void)showInView:(UIView *)view;
@end
