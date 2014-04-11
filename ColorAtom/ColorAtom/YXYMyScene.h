//
//  YXYMyScene.h
//  ColorAtom
//

//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Define.h"
#import "YXYContactHandler.h"
@interface YXYMyScene : SKScene <SKPhysicsContactDelegate>
@property SKSpriteNode *touchedAtom;
@property SKNode * debugOverlay; 
@end
