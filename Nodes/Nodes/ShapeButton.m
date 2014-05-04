//
//  ShapeButton.m
//  Nodes
//
//  Created by 杨萧玉 on 14-5-4.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "ShapeButton.h"

@implementation ShapeButton
-(id)init{
    if (self = [super initWithName:@"SKShapeNode"]) {
        SKShapeNode *shape = (SKShapeNode *)self.node;
        shape.path = CGPathCreateWithRect(CGRectMake(-50,-50, 100, 100), NULL);
        shape.strokeColor = [UIColor redColor];
    }
    return self;
}
@end
