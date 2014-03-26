//
//  YXYMyScene.h
//  DragDrop
//

//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
static NSString * const kAnimalNodeName = @"movable";
@interface YXYMyScene : SKScene
@property (nonatomic, strong) SKSpriteNode *background;
@property (nonatomic, strong) SKSpriteNode *selectedNode;

@end
