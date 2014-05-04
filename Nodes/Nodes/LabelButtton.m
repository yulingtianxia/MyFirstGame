//
//  LabelButtton.m
//  Nodes
//
//  Created by 杨萧玉 on 14-5-4.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "LabelButtton.h"

@implementation LabelButtton
-(id)init{
    if (self = [super initWithName:@"SKLabelNode"]) {
        SKLabelNode *label = (SKLabelNode *)self.node;
        label.text = @"Test";
        label.fontColor = [UIColor redColor];
        label.fontSize = 40;
        
    }
    return self;
}
@end
