//
//  ViewController.m
//  FlexCircle_Demo
//
//  Created by RenSihao on 15/10/16.
//  Copyright © 2015年 RenSihao. All rights reserved.
//

#import "ViewController.h"
#import "FlexCircleView.h"
#import "FlexCircleLayer.h"

@interface ViewController ()

@property (nonatomic, strong) UISlider *mySlider;
@property (nonatomic, strong) UILabel *currentValueLab;
@property (nonatomic, strong) FlexCircleView *flexCircleView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    [self.view addSubview:self.mySlider];
    [self.view addSubview:self.currentValueLab];
    [self.view addSubview:self.flexCircleView];
    
    //
    self.flexCircleView.circleLayer.currentProgress = 0.5;
}


//监听滑动
- (void)sliderDidChange:(UISlider *)sender
{
    [self.currentValueLab setText:[NSString stringWithFormat:@"value:%lf", sender.value]];
    self.flexCircleView.circleLayer.currentProgress = sender.value;
}

//lazyload
- (UISlider *)mySlider
{
    if(!_mySlider)
    {
        _mySlider = [[UISlider alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-200/2, self.view.frame.size.height/6 - 10/2, 200, 10)];
        _mySlider.value = 0.5;
        [_mySlider addTarget:self action:@selector(sliderDidChange:) forControlEvents:UIControlEventValueChanged];
    }
    return _mySlider;
}
- (UILabel *)currentValueLab
{
    if(!_currentValueLab)
    {
        _currentValueLab = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-200/2, self.view.frame.size.height/4-30/2, 200, 30)];
        _currentValueLab.backgroundColor = [UIColor grayColor];
        _currentValueLab.textAlignment = NSTextAlignmentCenter;
        _currentValueLab.textColor = [UIColor blackColor];
        _currentValueLab.text = [NSString stringWithFormat:@"value:%lf", self.mySlider.value];
    }
    return _currentValueLab;
}
- (FlexCircleView *)flexCircleView
{
    if(!_flexCircleView)
    {
        _flexCircleView = [[FlexCircleView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-300/2, self.view.frame.size.height/2-300/2, 300, 300)];
        _flexCircleView.backgroundColor = [UIColor lightGrayColor];
    }
    return _flexCircleView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
