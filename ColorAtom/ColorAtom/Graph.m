//
//  Graph.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-21.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "Graph.h"

@implementation Graph
@synthesize nodes;
@synthesize sets;
-(id) initWithNodes:(NSArray*) nodeArr{
    if (self=[super init]) {
        //初始化所有节点，将其访问信息设置为未被访问
        nodes = [NSMutableArray arrayWithArray:nodeArr];
        sets = [NSMutableArray array];
        for (int i=0; i<[nodes count]; i++) {
//            The userData property is initially nil. You have to create a dictionary and assign it first
            ((SKSpriteNode *)nodes[i]).userData = [NSMutableDictionary dictionary];
            [((SKSpriteNode *)nodes[i]).userData setObject:@"WHITE" forKey:@"visited"];
            
        }
        //遍历数组nodes中所有节点，如果节点未被访问，则调用深度优先搜索算法访问之
        for (int i=0; i<[nodes count]; i++) {
            if ([[((SKSpriteNode *)nodes[i]).userData objectForKey:@"visited"] isEqualToString:@"WHITE"]) {
                [sets addObject:[NSMutableSet setWithObject:nodes[i]]];
                [self DFSVisitNode:nodes[i]];
            }
        }
    }
    return self;
}
//深度优先搜索算法
-(void)DFSVisitNode:(SKSpriteNode *) node{
    [node.userData setObject:@"GRAY" forKey:@"visited"];//将节点node标记为正在访问
    NSArray *adj = node.physicsBody.joints;//获得节点node的所有的边
    for (int i = 0; i<[adj count]; i++) {
        //根据边adj[i]来找到与节点node相连的另一个节点v
        SKPhysicsJoint *joint = adj[i];
        SKSpriteNode *v;
        if ([joint.bodyA isEqual:node.physicsBody]) {
            v = (SKSpriteNode *)joint.bodyB.node;
        }
        else{
            v = (SKSpriteNode *)joint.bodyA.node;
        }
        //如果v没被访问过，那就将其纳入节点node所在的集合，并记录节点v的父节点为node
        if ([[v.userData objectForKey:@"visited"] isEqualToString:@"WHITE"]) {
            [v.userData setObject:node forKey:@"parent"];
            for (int j=0; j<[sets count]; j++) {
                if ([sets[j] containsObject:node]) {
                    [sets[j] addObject:v];
                }
            }
            [self DFSVisitNode:v];//递归访问节点v的子结点
        }
    }
    [node.userData setObject:@"BLACK" forKey:@"visited"];//将节点node标记为访问结束
}

@end
