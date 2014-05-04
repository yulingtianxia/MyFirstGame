//
//  NodeButton.m
//  Nodes
//
//  Created by 杨萧玉 on 14-5-4.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "NodeButton.h"

@implementation NodeButton
-(id)init{
    if (self = [super initWithName:@"SKNode"]) {
        SKNode *sknode = (SKNode *)self.node;
        SKSpriteNode *fill = [[SKSpriteNode alloc] init];
        fill.size = CGSizeMake(100, 100);
        fill.color = [UIColor redColor];
        fill.colorBlendFactor = 1;
//        [sknode addChild:fill];
    }
    return self;
}
@end
