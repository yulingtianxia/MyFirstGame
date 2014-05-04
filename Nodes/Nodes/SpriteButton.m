//
//  SpriteButton.m
//  Nodes
//
//  Created by 杨萧玉 on 14-5-4.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "SpriteButton.h"

@implementation SpriteButton
-(id)init{
    if (self=[super initWithName:@"SKSpriteNode"]) {
        SKSpriteNode *sprite = (SKSpriteNode*)self.node;
        sprite.size = CGSizeMake(100, 100);
        sprite.color = [UIColor redColor];
        sprite.colorBlendFactor = 1;

    }
    return self;
}
@end
