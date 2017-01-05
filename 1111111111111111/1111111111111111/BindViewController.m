//
//  BindViewController.m
//  1111111111111111
//
//  Created by 雨 on 16/11/11.
//  Copyright © 2016年 RYT. All rights reserved.
//

#import "BindViewController.h"
#import "BindFooterReusableView.h"
#import "BindCell.h"
#import "BindModel.h"
#import "MarkView.h"

#define kBounds [UIScreen mainScreen].bounds
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

static NSString *cellID = @"BindCell";
static NSString *cellFooterID = @"cellFooterID";

@interface BindViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MarkViewDelegate>
{
    MarkView *markView;
    NSInteger currentItem;
    BOOL isAddMode;
    NSInteger maxCount;
}

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation BindViewController

- (void)loadView {
    [super loadView];
    UIView *view = [[UIView alloc]initWithFrame:kBounds];
    view.backgroundColor = [UIColor whiteColor];
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"绑定";
    [self initData];
    [self.view addSubview:self.collectionView];
    
}

- (void)initData {
    maxCount = 5;
    _dataArray = [NSMutableArray arrayWithArray:@[[self addModel]]];
}

#pragma mark - private

- (void)hiddenKeyboard {
    [self.view endEditing:YES];
}

- (void)cellEvent:(NSInteger)index model:(BindModel *)model item:(NSInteger)item {
    [self.view endEditing:YES];
    if (index == 0)
    {
        [self domainEvent:item model:model];
    }
    else if (index == 1)
    {
        [self selectEvent:item model:model];
    }
}

- (void)editChanged:(NSString *)text item:(NSInteger)item {
    [_dataArray enumerateObjectsUsingBlock:^(BindModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == item) {
            obj.carNumber = text;
            [_dataArray replaceObjectAtIndex:idx withObject:obj];
//            [_collectionView reloadData];//此处只需修改数据源
        }
    }];
}

- (void)footerEvent:(NSInteger)index mode:(BOOL)mode {
    [self.view endEditing:YES];
    if (index == 0) {
        if (mode) {
            //新增
            if (_dataArray.count >= maxCount) {
                return;
            }
            [_dataArray addObject:[self addModel]];
            isAddMode = NO;
            [_collectionView reloadData];
        } else {
            //确定
            [_dataArray enumerateObjectsUsingBlock:^(BindModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (!obj.isBind) {
                    
                    if(obj.carNumber==nil||obj.carNumber==NULL||[obj.carNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0){
                        return;
                    }
                    obj.carNumber = [obj.carNumber uppercaseString];

                    obj.isBind = YES;
                    obj.isSelected = NO;
                    [_dataArray replaceObjectAtIndex:idx withObject:obj];
                    isAddMode = YES;
                    [_collectionView reloadData];
                }
            }];
        }
    } else if (index == 1) {
        //解除绑定
        [_dataArray enumerateObjectsUsingBlock:^(BindModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.isSelected) {
                [_dataArray removeObject:obj];
                
//                if (obj.carNumber.length == 0) {
//                    [_dataArray addObject:[self addModel]];
//                    isAddMode = NO;
//                }else{
//                    isAddMode = YES;
//                }

                [_collectionView reloadData];
            }
        }];
    }
}

- (BindModel *)addModel {
    BindModel *model = [BindModel new];
    model.domain = @"苏";
    return model;
}

- (void)domainEvent:(NSInteger)item model:(BindModel *)model {
    currentItem = item;
    markView = [[MarkView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) withClassArray:@[@"京",@"津",@"沪",@"渝",@"冀",@"豫",@"云",@"辽",@"黑",@"湘",@"皖",@"鲁",@"新",@"苏",@"浙",@"赣",@"鄂",@"桂",@"甘",@"晋",@"陕",@"吉",@"闽",@"贵",@"粤",@"青",@"藏",@"川",@"宁",@"琼",@"台"]];
    markView.delegate = self;
    [markView showInView:self.view];
}

- (void)selectEvent:(NSInteger)item model:(BindModel *)model {
    currentItem = item;
    [_dataArray enumerateObjectsUsingBlock:^(BindModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == currentItem) {
            obj.isSelected = !obj.isSelected;
            [_dataArray replaceObjectAtIndex:idx withObject:obj];
            [_collectionView reloadData];
        } else {
            if (obj.isSelected) {
                obj.isSelected = NO;
                [_dataArray replaceObjectAtIndex:idx withObject:obj];
                [_collectionView reloadData];
            }
        }
    }];
}

#pragma mark - MarkViewDelegate

- (void)didFinishMarkView:(NSString *)date {
    [_dataArray enumerateObjectsUsingBlock:^(BindModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == currentItem) {
            obj.domain = date;
            [_dataArray replaceObjectAtIndex:idx withObject:obj];
            [_collectionView reloadData];
        }
    }];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kScreenWidth-34, 40);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 30;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(50, 0, 70, 0);
}

#pragma mark - UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self)weakSelf = self;
    BindCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    [cell configCellWith:_dataArray[indexPath.item]];
    cell.event = ^(NSInteger index,BindModel *model) {
        [weakSelf cellEvent:index model:model item:indexPath.item];
    };
    cell.changed = ^(NSString *text) {
        [weakSelf editChanged:text item:indexPath.item];
    };
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqual:UICollectionElementKindSectionFooter]) {
        __weak typeof(self)weakSelf = self;
        BindFooterReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:cellFooterID forIndexPath:indexPath];
        footer.event = ^(NSInteger index,BOOL mode) {
            [weakSelf footerEvent:index mode:mode];
        };
        [footer configAddMode:isAddMode];
        return footer;
    }
    return nil;
}

#pragma mark - property

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        _collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:self.flowLayout];
        _collectionView.scrollEnabled = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[BindCell class] forCellWithReuseIdentifier:cellID];
        [_collectionView registerClass:[BindFooterReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:cellFooterID];
        [_collectionView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenKeyboard)]];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (_flowLayout == nil) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        [_flowLayout setFooterReferenceSize:CGSizeMake(kScreenWidth, 100)];
    }
    return _flowLayout;
}

@end
