//
//  FlexCircleLayer.m
//  FlexCircle_Demo
//
//  Created by RenSihao on 15/10/16.
//  Copyright © 2015年 RenSihao. All rights reserved.
//

#import "FlexCircleLayer.h"
#import <UIKit/UIKit.h>

#define outsideRectSize 100

typedef NS_ENUM(NSInteger, MovingPoint)
{
    Point_D,
    Point_B
    
};

@interface FlexCircleLayer ()

@property (nonatomic, assign) CGRect outsideRect; //外接矩形的frame
@property (nonatomic, assign) CGFloat previousProgress; //记录上次progress
@property (nonatomic, assign) MovingPoint movePoint; //实时记录滑动方向
@end


@implementation FlexCircleLayer

//- (instancetype)init
//{
//    if(self = [super init])
//    {
//        self.previousProgress = 0.5;
//    }
//    return self;
//}

//实时更新当前progress，并重绘
- (void)setCurrentProgress:(CGFloat)currentProgress
{
    _currentProgress = currentProgress;
    
    //只要外接矩形在左侧，则改变B点；在右边，改变D点
    if (currentProgress <= 0.5) {
        
        self.movePoint = Point_B;
        NSLog(@"B点动");
        
    }else{
        
        self.movePoint = Point_D;
        NSLog(@"D点动");
    }
    
    self.previousProgress = currentProgress;
    
    
    CGFloat origin_x = self.position.x - outsideRectSize/2 + (currentProgress - 0.5)*(self.frame.size.width - outsideRectSize);
    CGFloat origin_y = self.position.y - outsideRectSize/2;
    
    self.outsideRect = CGRectMake(origin_x, origin_y, outsideRectSize, outsideRectSize);
    
    [self setNeedsDisplay];
}

- (void)drawInContext:(CGContextRef)ctx
{
    //A-C1、B-C2... 的距离，当设置为正方形边长的1/3.6倍时，画出来的圆弧完美贴合圆形
    CGFloat offset = self.outsideRect.size.width / 3.6;
    
    //A.B.C.D实际需要移动的距离.系数为滑块偏离中点0.5的绝对值再乘以2.当滑到两端的时候，movedDistance为最大值：「外接矩形宽度的1/5」
    CGFloat movedDistance = (self.outsideRect.size.width / 6) * fabs(self.currentProgress - 0.5) * 2;
    
    //方便下方计算各点坐标，先算出外接矩形的中心点坐标
    CGPoint rectCenter = CGPointMake(self.outsideRect.origin.x + self.outsideRect.size.width/2, self.outsideRect.origin.y + self.outsideRect.size.height/2);
    
    //外接矩形的四个切点
    CGPoint pointA = CGPointMake(rectCenter.x, self.outsideRect.origin.y + movedDistance);
    CGPoint pointB = CGPointMake(self.movePoint == Point_D ? rectCenter.x + self.outsideRect.size.width/2 : rectCenter.x + self.outsideRect.size.width/2 + movedDistance*2, rectCenter.y);
    CGPoint pointC = CGPointMake(rectCenter.x, rectCenter.y + self.outsideRect.size.height/2 - movedDistance);
    CGPoint pointD = CGPointMake(self.movePoint == Point_D ? self.outsideRect.origin.x - movedDistance*2 : self.outsideRect.origin.x, rectCenter.y);
    
    
    //外接矩形的八个辅助控制点
    CGPoint c1 = CGPointMake(pointA.x + offset, pointA.y);
    CGPoint c2 = CGPointMake(pointB.x, self.movePoint == Point_D ? pointB.y - offset : pointB.y - offset + movedDistance);
    
    CGPoint c3 = CGPointMake(pointB.x, self.movePoint == Point_D ? pointB.y + offset : pointB.y + offset - movedDistance);
    CGPoint c4 = CGPointMake(pointC.x + offset, pointC.y);
    
    CGPoint c5 = CGPointMake(pointC.x - offset, pointC.y);
    CGPoint c6 = CGPointMake(pointD.x, self.movePoint == Point_D ? pointD.y + offset - movedDistance : pointD.y + offset);
    
    CGPoint c7 = CGPointMake(pointD.x, self.movePoint == Point_D ? pointD.y - offset + movedDistance : pointD.y - offset);
    CGPoint c8 = CGPointMake(pointA.x - offset, pointA.y);
    
    //圆的边界
    UIBezierPath* ovalPath = [UIBezierPath bezierPath];
    [ovalPath moveToPoint: pointA];
    [ovalPath addCurveToPoint:pointB controlPoint1:c1 controlPoint2:c2];
    [ovalPath addCurveToPoint:pointC controlPoint1:c3 controlPoint2:c4];
    [ovalPath addCurveToPoint:pointD controlPoint1:c5 controlPoint2:c6];
    [ovalPath addCurveToPoint:pointA controlPoint1:c7 controlPoint2:c8];
    [ovalPath closePath];
    
    CGContextAddPath(ctx, ovalPath.CGPath);
    CGContextSetStrokeColorWithColor(ctx, [UIColor blackColor].CGColor);
    CGContextSetFillColorWithColor(ctx, [UIColor yellowColor].CGColor);
    CGContextSetLineDash(ctx, 0, NULL, 0); //2
    CGContextDrawPath(ctx, kCGPathFillStroke); //同时给线条和线条包围的内部区域填充颜色
    
}














@end
