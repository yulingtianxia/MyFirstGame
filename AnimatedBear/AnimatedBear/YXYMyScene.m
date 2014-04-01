//
//  YXYMyScene.m
//  AnimatedBear
//
//  Created by 杨萧玉 on 14-4-1.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "YXYMyScene.h"

@implementation YXYMyScene
@synthesize bear;
@synthesize bearWalkingFrames;
-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        NSMutableArray *walkFrames = [NSMutableArray array];
        SKTextureAtlas *bearAnimatedAtlas = [SKTextureAtlas atlasNamed:@"BearImages"];
        int numImages = [[bearAnimatedAtlas textureNames] count];
        for (int i=1; i<=numImages/2; i++) {
            NSString *textureName = [NSString stringWithFormat:@"bear%d", i];
            SKTexture *temp = [bearAnimatedAtlas textureNamed:textureName];
            [walkFrames addObject:temp];
        }
        bearWalkingFrames = walkFrames;
        SKTexture *temp = bearWalkingFrames[0];
        bear = [SKSpriteNode spriteNodeWithTexture:temp];
        bear.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:bear];
        [self walkingBear];
    }
    return self;
}

-(void)walkingBear
{
    //This is our general runAction method to make our bear walk.
    [bear runAction:[SKAction repeatActionForever:
                      [SKAction animateWithTextures:bearWalkingFrames
                                       timePerFrame:0.1f
                                             resize:NO
                                            restore:YES]] withKey:@"walkingInPlaceBear"];
    return;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
