//
//  YXYMyScene.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-11.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "PlayFieldScene.h"

@implementation PlayFieldScene
@synthesize touchedAtom;

bool isPanningAtom = NO;
bool isAllAtomStatic = YES;
-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        self.debugOverlay = [SKNode node];
        [self addChild:self.debugOverlay];
        self.name = PlayFieldName;
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsBody.categoryBitMask = PlayFieldCategory;
        self.backgroundColor = [SKColor colorWithRed:1 green:1 blue:1 alpha:1.0];
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;
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
    AtomNode *Atom = [[AtomNode alloc] init];
    Atom.position = CGPointMake(skRand(AtomRadius, self.size.width-AtomRadius),skRand(AtomRadius, self.size.height-AtomRadius));
    [self addChild:Atom];
}

- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer {
	if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint touchLocation = [recognizer locationInView:recognizer.view];
        touchLocation = [self convertPointFromView:touchLocation];
        AtomNode *touchedNode = (AtomNode *)[self nodeAtPoint:touchLocation];
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

#pragma mark SKPhysicsContactDelegate
-(void)didBeginContact:(SKPhysicsContact *)contact
{
    //A->B
    ContactVisitor *visitorA = [ContactVisitor contactVisitorWithBody:contact.bodyA forContact:contact];
    VisitablePhysicsBody *visitableBodyB = [[VisitablePhysicsBody alloc] initWithBody:contact.bodyB];
    [visitableBodyB acceptVisitor:visitorA];
//    //B->A
//    ContactVisitor *visitorB = [ContactVisitor contactVisitorWithBody:contact.bodyB forContact:contact];
//    VisitablePhysicsBody *visitableBodyA = [[VisitablePhysicsBody alloc] initWithBody:contact.bodyA];
//    [visitableBodyA acceptVisitor:visitorB];
    
}
@end
