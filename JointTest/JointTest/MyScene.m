//
//  MyScene.m
//  JointTest
//
//  Created by 杨萧玉 on 14-4-21.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        NSMutableArray *nodes = [NSMutableArray array];
        for (int i=0; i<10; i++) {
            SKSpriteNode *node = [[SKSpriteNode alloc]init];
            [nodes addObject:node];
        }
        SKPhysicsJointFixed joint = [SKPhysicsJointFixed jointWithBodyA:<#(SKPhysicsBody *)#> bodyB:<#(SKPhysicsBody *)#> anchor:<#(CGPoint)#>]
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    

}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
