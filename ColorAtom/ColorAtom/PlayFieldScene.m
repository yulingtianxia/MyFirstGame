//
//  YXYMyScene.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-11.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "PlayFieldScene.h"

@implementation PlayFieldScene

@synthesize debugOverlay;
@synthesize longPressPosition;
@synthesize panPosition;
@synthesize playArea;
@synthesize background;
-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        debugOverlay = [[YXYDebugNode alloc] init];
        debugOverlay.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:debugOverlay];
        playArea = [[PlayerArea alloc] init];
        [self addChild:playArea];
        [playArea beginWork];
        background = [[Background alloc] init];
        background.position = CGPointMake(self.size.width/2, self.size.height/2+AtomRadius);
        [self addChild:background];
        self.name = PlayFieldName;
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, 0, 0, self.size.height);
        CGPathAddLineToPoint(path, 0, 0, 0);
        CGPathAddLineToPoint(path, 0, self.size.width, 0);
        CGPathAddLineToPoint(path, 0, self.size.width, self.size.height);
        self.physicsBody = [SKPhysicsBody bodyWithEdgeChainFromPath:path];
//        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsBody.categoryBitMask = PlayFieldCategory;
        self.backgroundColor = [SKColor clearColor];
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;

        [self createAtomMinus];
    }
    return self;
}
-(void)didMoveToView:(SKView *)view
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
    [[self view] addGestureRecognizer:pan];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressFrom:)];
    [[self view] addGestureRecognizer:longPress];
    
}
-(void)didSimulatePhysics
{
    [self enumerateChildNodesWithName:AtomMinusName usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.y<3*AtomRadius) {
            SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
            SKScene * gameOverScene = [[GameOverScene alloc] initWithSize:self.size won:NO];
            [self.view presentScene:gameOverScene transition: reveal];
            *stop=YES;
            [node removeFromParent];
        }
        
    }];
    
    //add debug node
    [self addChild:debugOverlay];

}
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */

    //添加debug信息
    [debugOverlay removeFromParent];
//    [debugOverlay removeAllChildren];
}
#pragma mark MyMethod

-(void)createAtomPlusAtPosition:(CGPoint) position
{
    AtomNode *Atom = [[AtomPlusNode alloc] init];
    Atom.position = CGPointMake(position.x,AtomRadius);
    playArea.fillColor = Atom.color;
    playArea.strokeColor = Atom.color;
    [self addChild:Atom];
    [self runAction:[SKAction playSoundFileNamed:@"pew-pew-lei.caf" waitForCompletion:NO]];
}

-(void)createAtomMinus{
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction runBlock:^{
        AtomNode *Atom = [[AtomMinusNode alloc] init];
        Atom.position = CGPointMake(skRand(AtomRadius, self.size.width-AtomRadius),self.size.height-AtomRadius);
        
        [self addChild:Atom];
    }],
                                                                       [SKAction waitForDuration:AtomMinusCreateInterval withRange:0.5]]]]];
    
    
}
-(void)handlePanFrom:(UILongPressGestureRecognizer *)recognizer{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        //        debugOverlay.label.text = @"Began";
        CGPoint touchLocation = [recognizer locationInView:recognizer.view];
        touchLocation = [self convertPointFromView:touchLocation];
        panPosition = touchLocation;
        SKAction *createAtomPlusAction = [SKAction repeatActionForever:[SKAction sequence:@[[SKAction runBlock:^{
            [self createAtomPlusAtPosition:panPosition];
        }],
                                                                                            [SKAction waitForDuration:AtomPlusCreateInterval]]]];
        
        [self runAction:createAtomPlusAction withKey:CreateAtomPlus];
        
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged){
        //        debugOverlay.label.text = @"Changed";
        CGPoint touchLocation = [recognizer locationInView:recognizer.view];
        touchLocation = [self convertPointFromView:touchLocation];
        panPosition = touchLocation;
        
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded){
        //        debugOverlay.label.text = @"Ended";
        [self removeActionForKey:CreateAtomPlus];
    }
    else{
        //        debugOverlay.label.text = @"No";
    }
}

-(void)handleLongPressFrom:(UILongPressGestureRecognizer *)recognizer{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
//        debugOverlay.label.text = @"Began";
        CGPoint touchLocation = [recognizer locationInView:recognizer.view];
        touchLocation = [self convertPointFromView:touchLocation];
        longPressPosition = touchLocation;
        SKAction *createAtomPlusAction = [SKAction repeatActionForever:[SKAction sequence:@[[SKAction runBlock:^{
            [self createAtomPlusAtPosition:longPressPosition];
        }],
                                                                                           [SKAction waitForDuration:AtomPlusCreateInterval]]]];
        
        [self runAction:createAtomPlusAction withKey:CreateAtomPlus];
        
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged){
//        debugOverlay.label.text = @"Changed";
        CGPoint touchLocation = [recognizer locationInView:recognizer.view];
        touchLocation = [self convertPointFromView:touchLocation];
        longPressPosition = touchLocation;
        
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded){
//        debugOverlay.label.text = @"Ended";
        [self removeActionForKey:CreateAtomPlus];
    }
    else{
//        debugOverlay.label.text = @"No";
    }
}

#pragma mark SKPhysicsContactDelegate
-(void)didBeginContact:(SKPhysicsContact *)contact
{
    //A->B
    ContactVisitor *visitorA = [ContactVisitor contactVisitorWithBody:contact.bodyA forContact:contact];
    VisitablePhysicsBody *visitableBodyB = [[VisitablePhysicsBody alloc] initWithBody:contact.bodyB];
    [visitableBodyB acceptVisitor:visitorA];
    //B->A
    ContactVisitor *visitorB = [ContactVisitor contactVisitorWithBody:contact.bodyB forContact:contact];
    VisitablePhysicsBody *visitableBodyA = [[VisitablePhysicsBody alloc] initWithBody:contact.bodyA];
    [visitableBodyA acceptVisitor:visitorB];
}
@end
