//
//  FlexCircleView.m
//  FlexCircle_Demo
//
//  Created by RenSihao on 15/10/16.
//  Copyright © 2015年 RenSihao. All rights reserved.
//

#import "FlexCircleView.h"
#import "FlexCircleLayer.h"

@implementation FlexCircleView

+ (Class)layerClass
{
    return [FlexCircleLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.circleLayer = [FlexCircleLayer layer];
        self.circleLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.circleLayer.contentsScale = [UIScreen mainScreen].scale;
        
        [self.layer addSublayer:self.circleLayer];
    }
    return self;
}

@end
