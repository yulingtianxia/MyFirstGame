//
//  YXYMyScene.m
//  Physics
//
//  Created by 杨萧玉 on 14-4-9.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//
#define huntRadius 50
#import "YXYMyScene.h"

@implementation YXYMyScene
@synthesize hunter;
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        hunter = [[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"Spaceship"]] color:[UIColor clearColor] size:CGSizeMake(huntRadius, huntRadius)];
        hunter.position=CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        hunter.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:hunter.size];
        hunter.physicsBody.dynamic = NO;
        [self addChild:hunter];
        SKAction *pulseRed = [SKAction sequence:@[
                                                  [SKAction colorizeWithColor:[SKColor redColor] colorBlendFactor:1.0 duration:0.15],
                                                  [SKAction waitForDuration:0.1],
                                                  [SKAction colorizeWithColorBlendFactor:0.0 duration:0.15]]];
        [hunter runAction: pulseRed];

        [hunter runAction:[SKAction repeatActionForever:pulseRed]];
        SKAction * makeRocks = [SKAction sequence:@[
                                                    [SKAction performSelector:@selector(addRock) onTarget:self],
                                                    [SKAction waitForDuration:0.10 withRange:0.15]
                                                    ]];
        [self runAction:[SKAction repeatActionForever:makeRocks]];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

static inline CGFloat skRandf() {
    return rand()/(CGFloat)RAND_MAX;
}

static inline CGFloat skRand(CGFloat low, CGFloat high) {
    return skRandf()*(high - low) + low;
}

- (void)addRock
{
    SKSpriteNode *rock = [[SKSpriteNode alloc] initWithColor:[SKColor brownColor] size:CGSizeMake(8,8)];
    rock.position = CGPointMake(skRand(0, self.size.width),self.size.height-50);
    rock.name = @"rock";
    rock.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rock.size];
    rock.physicsBody.usesPreciseCollisionDetection = YES;
    [self addChild:rock];
}

-(void) didSimulatePhysics{
    [self enumerateChildNodesWithName:@"rock" usingBlock:^(SKNode *node, BOOL *stop){
        if (node.position.y <0)
            [node removeFromParent];
    }];
}
@end
