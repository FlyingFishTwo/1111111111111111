//
//  BindFooterReusableView.h
//  1111111111111111
//
//  Created by 雨 on 16/11/11.
//  Copyright © 2016年 RYT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickEvent)(NSInteger index, BOOL mode);

@interface BindFooterReusableView : UICollectionReusableView

@property (nonatomic, copy) ClickEvent event;
- (void)configAddMode:(BOOL)mode;

@end
