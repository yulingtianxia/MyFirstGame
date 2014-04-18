//
//  AtomMinusContactVisitor.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-18.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "AtomMinusNodeContactVisitor.h"
#import "AtomNode.h"
#import "PlayFieldScene.h"
@implementation AtomMinusNodeContactVisitor
-(void) visitAtomPlusNode:(SKPhysicsBody*) anotherAtomBody
{
    AtomNode *thisAtom = (AtomNode*)self.body.node;
    AtomNode *anotherAtom = (AtomNode*)anotherAtomBody.node;
    //处理碰撞后的结果
    //    NSLog(@"%@->%@",thisAtom.name,anotherAtom.name);
    [thisAtom changeColorWithDiffAtom:anotherAtom];
    
}

-(void) visitAtomMinusNode:(SKPhysicsBody*) anotherAtomBody
{
    AtomNode *thisAtom = (AtomNode*)self.body.node;
    AtomNode *anotherAtom = (AtomNode*)anotherAtomBody.node;
    //处理碰撞后的结果
    //    NSLog(@"%@->%@",thisAtom.name,anotherAtom.name);
    [thisAtom changeColorWithSameAtom:anotherAtom];
    SKPhysicsJointFixed *fix = [SKPhysicsJointFixed jointWithBodyA:self.body bodyB:anotherAtomBody anchor:self.contact.contactPoint];
    [self.body.node.scene.physicsWorld addJoint:fix];
}

-(void) visitPlayFieldScene:(SKPhysicsBody*) playfieldBody
{
    AtomNode *atom = (AtomNode*)self.body.node;
    PlayFieldScene *playfield = (PlayFieldScene*) playfieldBody.node;
    NSLog(@"%@->%@",atom.name,playfield.name);
}
@end
