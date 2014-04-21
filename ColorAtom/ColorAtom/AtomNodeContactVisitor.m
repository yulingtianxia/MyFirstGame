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
#import "Graph.h"
@implementation AtomNodeContactVisitor
-(void) visitAtomNode:(SKPhysicsBody*) anotherAtomBody
{
    AtomNode *thisAtom = (AtomNode*)self.body.node;
    AtomNode *anotherAtom = (AtomNode*)anotherAtomBody.node;
    //处理碰撞后的结果
//    NSLog(@"%@->%@",thisAtom.name,anotherAtom.name);
    SKPhysicsJointFixed *fix = [SKPhysicsJointFixed jointWithBodyA:self.body bodyB:anotherAtomBody anchor:self.contact.contactPoint];
    [thisAtom.scene.physicsWorld addJoint:fix];
    NSMutableArray *nodes = [NSMutableArray array];
    [thisAtom.scene enumerateChildNodesWithName:AtomName usingBlock:^(SKNode *node, BOOL *stop) {
        [nodes addObject:node];
    }];
    Graph *graph = [[Graph alloc] initWithNodes:nodes];
    for (int i=0; i<[graph.sets count]; i++) {
        NSLog(@"%@",graph.sets[i]);
    }
}
-(void) visitPlayFieldScene:(SKPhysicsBody*) playfieldBody
{
    AtomNode *atom = (AtomNode*)self.body.node;
    PlayFieldScene *playfield = (PlayFieldScene*) playfieldBody.node;
//    NSLog(@"%@->%@",atom.name,playfield.name);
}
@end
