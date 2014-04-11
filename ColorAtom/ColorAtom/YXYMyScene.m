//
//  YXYMyScene.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-11.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "YXYMyScene.h"

@implementation YXYMyScene
@synthesize touchedAtom;

bool isPanningAtom = NO;
bool isAllAtomStatic = YES;
-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.debugOverlay = [SKNode node];
        [self addChild:self.debugOverlay];
        
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.backgroundColor = [SKColor colorWithRed:1 green:1 blue:1 alpha:1.0];
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        [self makeAtom];
    }
    return self;
}
-(void)didMoveToView:(SKView *)view
{
    UIPanGestureRecognizer *gesturerecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
    [[self view] addGestureRecognizer:gesturerecognizer];
}
-(void)didSimulatePhysics
{
    [self CheckAtomsStatic];
    if (isPanningAtom==NO&&touchedAtom!=NULL&&
        isAllAtomStatic) {
        touchedAtom = NULL;
        [self makeAtom];
    }
    //add debug node
    [self addChild:self.debugOverlay];
    // add code to create and add debugging images to the debug node.
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    if (isPanningAtom) {
        label.text = @"是";
    }
    else{
        label.text = @"否";
    }
    label.fontSize = 40;
    label.fontColor = [SKColor blackColor];
    label.position = CGPointMake(self.size.width/2, self.size.height/2);
    
//    [self.debugOverlay addChild: label];

}
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    [self.debugOverlay removeFromParent];
    [self.debugOverlay removeAllChildren];
}
#pragma mark MyMethod
-(void)CheckAtomsStatic
{
    isAllAtomStatic = YES;
    [self enumerateChildNodesWithName:AtomName usingBlock:^(SKNode *node, BOOL *stop) {
        SKSpriteNode *atom = (SKSpriteNode *)node;
        if (fabs(atom.physicsBody.velocity.dx)<=ZERO&&fabs(atom.physicsBody.velocity.dy)<=ZERO) {
            atom.physicsBody.velocity = CGVectorMake(0, 0);
        }
        if (atom.physicsBody.velocity.dx!=0||atom.physicsBody.velocity.dy!=0) {
            isAllAtomStatic = NO;
            *stop = YES;
        }
    }];
    
}
-(void)makeAtom
{
    SKSpriteNode *Atom = [[SKSpriteNode alloc] initWithTexture:[SKTexture textureWithImageNamed:@"Atom"] color:[SKColor blackColor] size:CGSizeMake(AtomRadius*2, AtomRadius*2)];
    Atom.position = CGPointMake(skRand(AtomRadius, self.size.width-AtomRadius),skRand(AtomRadius, self.size.height-AtomRadius));
    Atom.colorBlendFactor = 1.0;
    Atom.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:AtomRadius];
    Atom.physicsBody.dynamic = YES;
    Atom.physicsBody.linearDamping = 0.8;
    Atom.name = AtomName;
    [self addChild:Atom];
}

- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer {
	if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint touchLocation = [recognizer locationInView:recognizer.view];
        touchLocation = [self convertPointFromView:touchLocation];
        SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchLocation];
        if (isAllAtomStatic&&[touchedNode.name isEqualToString:AtomName]) {
            touchedAtom = touchedNode;
            isPanningAtom = YES;
        }
        
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        CGPoint translation = [recognizer translationInView:recognizer.view];
        translation = CGPointMake(translation.x, -translation.y);
        if (isPanningAtom==YES) {
            touchedAtom.position = CGPointMake(touchedAtom.position.x+translation.x, touchedAtom.position.y+translation.y);
        }
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        if (isPanningAtom==YES) {
            CGPoint velocity = [recognizer velocityInView:recognizer.view];
            touchedAtom.physicsBody.velocity =CGVectorMake(velocity.x, -velocity.y);
            isPanningAtom = NO;
        }
    }
}

#pragma mark HelpMethod
static inline CGFloat skRandf() {
    return rand()/(CGFloat)RAND_MAX;
}

static inline CGFloat skRand(CGFloat low, CGFloat high) {
    return skRandf()*(high - low) + low;
}

@end
