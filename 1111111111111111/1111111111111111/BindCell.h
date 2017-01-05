//
//  BindCell.h
//  1111111111111111
//
//  Created by 雨 on 16/11/11.
//  Copyright © 2016年 RYT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BindModel;

typedef void(^CellClickEvent)(NSInteger index,BindModel *model);
typedef void(^CellEditChanged)(NSString *text);

@interface BindCell : UICollectionViewCell

@property (nonatomic, copy) CellClickEvent event;
@property (nonatomic, copy) CellEditChanged changed;

- (void)configCellWith:(BindModel *)model;

@end
