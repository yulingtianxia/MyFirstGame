//
//  AtomNodeContactVisitor.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-13.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "AtomPlusNodeContactVisitor.h"
#import "AtomNode.h"
#import "PlayFieldScene.h"
@implementation AtomPlusNodeContactVisitor



-(void) visitAtomPlusNode:(SKPhysicsBody*) anotherAtomBody
{
    AtomNode *thisAtom = (AtomNode*)self.body.node;
    AtomNode *anotherAtom = (AtomNode*)anotherAtomBody.node;
    //处理碰撞后的结果
//    NSLog(@"%@->%@",thisAtom.name,anotherAtom.name);
    ((PlayFieldScene *)thisAtom.parent).isPanningAtom = NO;
    [thisAtom changeColorWithAtom:anotherAtom];
    
}

-(void) visitAtomMinusNode:(SKPhysicsBody*) anotherAtomBody
{
    AtomNode *thisAtom = (AtomNode*)self.body.node;
    AtomNode *anotherAtom = (AtomNode*)anotherAtomBody.node;
    //处理碰撞后的结果
    //    NSLog(@"%@->%@",thisAtom.name,anotherAtom.name);
    ((PlayFieldScene *)thisAtom.parent).isPanningAtom = NO;
    [thisAtom changeColorWithAtom:anotherAtom];
    
}

-(void) visitPlayFieldScene:(SKPhysicsBody*) playfieldBody
{
    AtomNode *atom = (AtomNode*)self.body.node;
    PlayFieldScene *playfield = (PlayFieldScene*) playfieldBody.node;
    NSLog(@"%@->%@",atom.name,playfield.name);
}

@end
