//
//  YJYYTableViewCell.m
//  scrollView | 它的子类下拉图片放大
//
//  Created by 远洋 on 16/2/3.
//  Copyright © 2016年 yuayang. All rights reserved.
//

#import "YJYYTableViewCell.h"

@implementation YJYYTableViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //
    }
    return self;
}

#pragma mark - /********重写cell的setFrame方法改变分割线 让tableview的背景作为分割线*******/
-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    
    [super setFrame:frame];
}
@end
