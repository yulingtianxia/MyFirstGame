//
//  YXYMyScene.m
//  MyFirstGame
//
//  Created by 杨萧玉 on 14-3-21.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "YXYMyScene.h"
#import "YXYGameOverScene.h"
static const uint32_t projectileCategory     =  0x1 << 0;
static const uint32_t monsterCategory        =  0x1 << 1;
@implementation YXYMyScene

@synthesize player;
@synthesize background;
@synthesize lastSpawnTimeInterval;
@synthesize lastUpdateTimeInterval;
@synthesize zidanTimeInterval;
@synthesize monstersDestroyed;

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
//        NSLog(@"size:%@",NSStringFromCGSize(size));
        background = [SKSpriteNode spriteNodeWithImageNamed:@"background"];
        [background setAnchorPoint:CGPointZero];
        [self addChild:background];
        player = [SKSpriteNode spriteNodeWithImageNamed:@"player"];
        player.position = CGPointMake(player.size.width/2, self.frame.size.height/2);
        
        [background addChild:player];
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate=self;
    }
    return self;
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    // 获取时间增量
    // 如果我们运行的每秒帧数低于60，我们依然希望一切和每秒60帧移动的位移相同
    CFTimeInterval timeSinceLast = currentTime - lastUpdateTimeInterval;
    lastUpdateTimeInterval = currentTime;
    if (timeSinceLast > 1) { // 如果上次更新后得时间增量大于1秒
        timeSinceLast = 1.0 / 60.0;
        lastUpdateTimeInterval = currentTime;
    }
    
    [self updateWithTimeSinceLastUpdate:timeSinceLast];
}
- (void)addMonster {
    // 创建怪物Sprite
    SKSpriteNode * monster = [SKSpriteNode spriteNodeWithImageNamed:@"monster"];
    
    // 决定怪物在竖直方向上的出现位置
    int minY = monster.size.height / 2;
    int maxY = self.frame.size.height - monster.size.height / 2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    
    // Create the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    monster.position = CGPointMake(self.frame.size.width + monster.size.width/2, actualY);
    [background addChild:monster];
    monster.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:monster.size];
    monster.physicsBody.dynamic = YES;
    monster.physicsBody.categoryBitMask = monsterCategory;
    monster.physicsBody.contactTestBitMask = projectileCategory;
    monster.physicsBody.collisionBitMask = 0;
    // 设置怪物的速度
    int minDuration = 2.0;
    int maxDuration = 4.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    // Create the actions
    SKAction * actionMove = [SKAction moveTo:CGPointMake(-monster.size.width/2, actualY) duration:actualDuration];
    SKAction * actionMoveDone = [SKAction removeFromParent];
    SKAction * loseAction = [SKAction runBlock:^{
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        SKScene * gameOverScene = [[YXYGameOverScene alloc] initWithSize:self.size won:NO];
        [self.view presentScene:gameOverScene transition: reveal];
    }];
    [monster runAction:[SKAction sequence:@[actionMove, loseAction, actionMoveDone]]];
}
- (void)updateWithTimeSinceLastUpdate:(CFTimeInterval)timeSinceLast {
    lastSpawnTimeInterval += timeSinceLast;
    zidanTimeInterval+=timeSinceLast;
    if (lastSpawnTimeInterval > 1) {
        lastSpawnTimeInterval = 0;
        [self addMonster];
    }
    if (zidanTimeInterval > 0.3) {
        zidanTimeInterval = 0;
        SKSpriteNode * projectile = [SKSpriteNode spriteNodeWithImageNamed:@"projectile"];
        projectile.position = player.position;
        [background addChild:projectile];
        projectile.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:projectile.size];
        projectile.physicsBody.dynamic = YES;
        projectile.physicsBody.categoryBitMask = projectileCategory;
        projectile.physicsBody.contactTestBitMask = monsterCategory;
        projectile.physicsBody.collisionBitMask = 0;
        projectile.physicsBody.usesPreciseCollisionDetection = YES;
        [self runAction:[SKAction playSoundFileNamed:@"pew-pew-lei.caf" waitForCompletion:NO]];
        SKAction * projectileActionMove = [SKAction moveTo:CGPointMake(self.frame.size.width, projectile.position.y) duration:2];
        SKAction * projectileActionMoveDone = [SKAction removeFromParent];
        [projectile runAction:[SKAction sequence:@[projectileActionMove,projectileActionMoveDone]]];
    }
}

- (void)projectile:(SKSpriteNode *)projectile didCollideWithMonster:(SKSpriteNode *)monster {
    [projectile removeFromParent];
    [monster removeFromParent];
    self.monstersDestroyed++;
    if (self.monstersDestroyed == 30) {
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        SKScene * gameOverScene = [[YXYGameOverScene alloc] initWithSize:self.size won:YES];
        [self.view presentScene:gameOverScene transition: reveal];
    }
}
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self touchesMoved:touches withEvent:event];
}
-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"touchmoved");
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];

    // Create the actions
    SKAction * playerActionMove = [SKAction moveTo:CGPointMake(location.x, location.y) duration:0.25];
    [player runAction:playerActionMove];
    
    
}

#pragma mark SKPhysicsContactDelegate
- (void)didBeginContact:(SKPhysicsContact *)contact
{
    //这个方法传给你发生碰撞的两个物理外形（子弹和怪物），但是不能保证它们会按特定的顺序传你。所以有一部分代码是用来把它们按各自的种类掩码进行排序的。这样你稍后才能针对对象种类做操作。这部分的代码来源于苹果官方Adventure例子。
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    //方法的后一部分是用来检查这两个外形是否一个是子弹另一个是怪物，如果是就调用刚刚写的方法（指把它们从scene上移除的方法）。
    if ((firstBody.categoryBitMask & projectileCategory) != 0 &&
        (secondBody.categoryBitMask & monsterCategory) != 0)
    {
        [self projectile:(SKSpriteNode *) firstBody.node didCollideWithMonster:(SKSpriteNode *) secondBody.node];
    }
}
@end
