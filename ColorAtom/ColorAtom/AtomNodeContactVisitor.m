//
//  AtomNodeContactVisitor.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-13.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "AtomNodeContactVisitor.h"
#import "AtomNode.h"
#import "PlayFieldScene.h"
@implementation AtomNodeContactVisitor
-(void) visitAtomNode:(SKPhysicsBody*) anotherAtomBody
{
    AtomNode *thisAtom = (AtomNode*)self.body.node;
    AtomNode *anotherAtom = (AtomNode*)anotherAtomBody.node;
    //处理碰撞后的结果
    NSLog(@"%@->%@",thisAtom.name,anotherAtom.name);
}
-(void) visitPlayFieldScene:(SKPhysicsBody*) playfieldBody
{
    AtomNode *atom = (AtomNode*)self.body.node;
    PlayFieldScene *playfield = (PlayFieldScene*) playfieldBody.node;
    NSLog(@"%@->%@",atom.name,playfield.name);
}
@end
