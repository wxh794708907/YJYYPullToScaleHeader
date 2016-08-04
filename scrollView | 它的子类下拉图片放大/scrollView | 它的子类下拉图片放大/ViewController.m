//
//  ViewController.m
//  scrollView | 它的子类下拉图片放大
//
//  Created by 远洋 on 16/2/3.
//  Copyright © 2016年 yuayang. All rights reserved.
//

#import "ViewController.h"
#import "YJYYTableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
//全局的UIImageView
@property (nonatomic,strong)UIImageView * imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITableView * tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    
//    tableView.backgroundColor = [UIColor cyanColor];
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
    UIImage * headImage = [UIImage imageNamed:@"10"];
    //添加一个ImageView到头部
    UIImageView * imageView = [[UIImageView alloc]initWithImage:headImage];
    
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    //设置imageview的frame
    imageView.frame = CGRectMake(0, -headImage.size.height, headImage.size.width, headImage.size.height);
    
    self.imageView = imageView;
    
    //为了不挡住cell 将imageView插入到最下面一层
    [tableView insertSubview:imageView atIndex:0];
    
    tableView.contentInset = UIEdgeInsetsMake(headImage.size.height, 0, 0, 0);
    
    //还有一种下拉放大的方式是 图片一开始只显示一半 也就是contentInset显示图片的一半高度
//    tableView.contentInset = UIEdgeInsetsMake(headImage.size.height * 0.5, 0, 0, 0);

    
}


#pragma mark - /********监听滚动的方法*******/
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    //由于下拉contentoffset是负数 为了方便计算 将contentoffset设置为0 前面添加一个负数的目的就是如果往下拉 那么offSet就会显示正数
    CGFloat offSet = -(scrollView.contentOffset.y + self.imageView.image.size.height);
    
#warning 如果是采用开始显示一半图片高度 那么这里的offSet也只需要显示一半的高度就可以了 及
    //    CGFloat offSet = -(scrollView.contentOffset.y + self.imageView.image.size.height)*0.5;

    NSLog(@"%f",offSet);
    
    //计算出缩放比例
    CGFloat scale = self.imageView.image.size.width / self.imageView.image.size.height;
    //因为我们是判断向下拉动放大图片 所以如果是向上拉动 就直接返回
    if (offSet < 0) return;
    
    //开始要修改头部视图的frame 为了达到放大缩小的目的 所以先取出头部视图
    CGRect headRect = self.imageView.frame;
    
    //设置x的位置 如果不写这句 那么就没有缩放效果了
    headRect.origin.x = -offSet;
    
    //因为在viewDidLoad中设置了图片的填充模式 所以宽度拉伸之后 高度也会相应的拉伸
    
    //设置宽度 加2*offSet的原因是 x的初始位置变味了-offset 所以左右各-offset就是两倍
    headRect.size.width = (self.imageView.image.size.height +2*offSet)*scale;
    
    //赋值回去
    self.imageView.frame = headRect;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ID = @"YJYYTableViewCell";
    
    YJYYTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[YJYYTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"我是第:%zd个cell",indexPath.row];
    return cell;
}


@end
