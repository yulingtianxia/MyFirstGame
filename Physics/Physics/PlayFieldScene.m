//
//  YXYMyScene.m
//  Physics
//
//  Created by 杨萧玉 on 14-4-9.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//
#define huntRadius 50
#import "PlayFieldScene.h"

@implementation PlayFieldScene
@synthesize hunter;
//@synthesize debugOverlay;
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
//        self.debugOverlay = [SKNode node];
//        [self addChild:self.debugOverlay];
        self.scaleMode = SKSceneScaleModeAspectFit;  
//        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        hunter = [[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"Spaceship"]] color:[UIColor clearColor] size:CGSizeMake(huntRadius, huntRadius)];
        hunter.position=CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        hunter.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:hunter.size];
        hunter.physicsBody.affectedByGravity = NO;
        hunter.physicsBody.dynamic = YES;
//        hunter.physicsBody.mass = 1;
        
        [self addChild:hunter];
        SKEmitterNode * fire = [self newSmokeEmitter];
        fire.position = CGPointMake(0, -hunter.size.height/2);
        [hunter addChild:fire];
//        SKAction *pulseRed = [SKAction sequence:@[
//                                                  [SKAction colorizeWithColor:[SKColor redColor] colorBlendFactor:1.0 duration:0.15],
//                                                  [SKAction waitForDuration:0.1],
//                                                  [SKAction colorizeWithColorBlendFactor:0.0 duration:0.15]]];
//
//        [hunter runAction:[SKAction repeatActionForever:pulseRed]];
        SKAction * makeForce = [SKAction runBlock:^{
            [hunter.physicsBody applyForce:CGVectorMake(10, 10)];
        }];
        [hunter runAction:makeForce];
        SKAction * makeRocks = [SKAction sequence:@[
                                                    [SKAction performSelector:@selector(addRock) onTarget:self],
                                                    [SKAction waitForDuration:0.10 withRange:0.15]
                                                    ]];
//        [self runAction:[SKAction repeatActionForever:makeRocks]];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
//    [self.debugOverlay removeFromParent];
//    [self.debugOverlay removeAllChildren];
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
//    rock.physicsBody.velocity = CGVectorMake(skRand(-500, 500), skRand(-500, 500));
//    [rock.physicsBody applyImpulse:CGVectorMake(10, 10)];
    rock.physicsBody.density = 5;
    rock.physicsBody.affectedByGravity = NO;
//    [rock.physicsBody applyTorque:500];
    [self addChild:rock];
    
}

- (SKEmitterNode *) newSmokeEmitter
{
    NSString *smokePath = [[NSBundle mainBundle] pathForResource:@"MyFire" ofType:@"sks"];
    SKEmitterNode *smoke = [NSKeyedUnarchiver unarchiveObjectWithFile:smokePath];
    return smoke;
}

-(void) didSimulatePhysics{
    [self enumerateChildNodesWithName:@"rock" usingBlock:^(SKNode *node, BOOL *stop){
        if (node.position.y <0)
            [node removeFromParent];
    }];
//    [self addChild:self.debugOverlay];
//    // add code to create and add debugging images to the debug node.
//    // This example displays a gravity vector.
//    SKShapeNode *gravityLine = [[SKShapeNode alloc] init];
//    gravityLine.position = CGPointMake (200,200);
//    
//    CGMutablePathRef path = CGPathCreateMutable();
//    CGPathMoveToPoint(path, NULL, 0.0, 0.0);
//    CGPathAddLineToPoint(path, 0, self.physicsWorld.gravity.dx*10, self.physicsWorld.gravity.dy*10);
//    CGPathCloseSubpath(path);
//    gravityLine.path = path;
//    CGPathRelease(path);
//    
//    [self.debugOverlay addChild: gravityLine];
}
@end
