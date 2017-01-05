//
//  UIColor+AddColor.h
//  Pic61
//
//  Created by Iphone on 15/3/23.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (AddColor)
+ (UIColor *) colorWithHexString: (NSString *)color;
+ (UIColor *) colorWithHexString: (NSString *)color alpha:(CGFloat)alpha;
+ (UIColor *) randomColor;
@end
