//
//  Graph.h
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-21.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import <Foundation/Foundation.h>
@import SpriteKit;
@interface Graph : NSObject
@property NSMutableArray *nodes;//节点数组
@property NSMutableArray *sets;//子图（联通图）数组，数组每个元素都是个集合，集合中包含这个子图中所有的node
-(id) initWithNodes:(NSArray*) nodeArr;
-(void)DFSVisitNode:(SKSpriteNode *) node;
@end
