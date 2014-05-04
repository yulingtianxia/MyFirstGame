//
//  MyScene.m
//  Nodes
//
//  Created by 杨萧玉 on 14-5-4.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "MyScene.h"
#import "SpriteButton.h"
#import "ShapeButton.h"
#import "LabelButtton.h"
#import "EmitterButton.h"
#import "NodeButton.h"
@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor whiteColor];
        CGMutablePathRef cross = CGPathCreateMutable();
        CGPathMoveToPoint(cross, NULL, 0, CGRectGetMidY(self.frame));
        CGPathAddLineToPoint(cross, NULL, CGRectGetMaxX(self.frame), CGRectGetMidY(self.frame));
        CGPathMoveToPoint(cross, NULL, CGRectGetMidX(self.frame), 0);
        CGPathAddLineToPoint(cross, NULL, CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame));
        SKShapeNode *crossShape = [[SKShapeNode alloc] init];
        crossShape.strokeColor = [UIColor blackColor];
        crossShape.path = cross;
        [self addChild:crossShape];
        
        
        //SKSpriteNode
        SpriteButton * sprite = [[SpriteButton alloc]init];
        sprite.position = CGPointMake(CGRectGetMidX(self.frame), 0);
        sprite.delegate = self;
        [self addChild:sprite];
        //SKShapeNode
        ShapeButton * shape = [[ShapeButton alloc] init];
        shape.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(sprite.frame));
        shape.delegate = self;
        [self addChild:shape];
        //SKLabelNode
        LabelButtton * label = [[LabelButtton alloc] init];
        label.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(shape.frame));
        label.delegate = self;
        [self addChild:label];
        //SKScene
        EmitterButton * fire = [[EmitterButton alloc] init];
        fire.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(label.frame));
        fire.delegate = self;
        [self addChild:fire];
        //SKNode
        NodeButton * node = [[NodeButton alloc] init];
        node.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(fire.frame));
        node.delegate = self;
        [self addChild:node];
    }
    return self;
}

-(void)drawOriginal:(Button *) button{
    CGPoint point = [self convertPoint:CGPointMake(0, 0) fromNode:button.node];
    
    button.circle.path = CGPathCreateWithEllipseInRect(CGRectMake(point.x-5, point.y-5, 10, 10), NULL);
    button.circle.strokeColor = [UIColor blackColor];
    [self runAction:[SKAction runBlock:^{
        if (button.circle.parent==NULL) {
            [self addChild:button.circle];
        }
        
    }]];
}

-(void)eraseOriginal:(Button *) button{
    [button.circle removeFromParent];
}
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
