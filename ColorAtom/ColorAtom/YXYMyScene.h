//
//  YXYMyScene.h
//  ColorAtom
//

//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Define.h"
#import "NodeCategories.h"
#import "RandomHelper.h"
#import "YXYAtomNode.h"
@interface YXYMyScene : SKScene <SKPhysicsContactDelegate>
@property YXYAtomNode *touchedAtom;
@property SKNode * debugOverlay; 
@end
