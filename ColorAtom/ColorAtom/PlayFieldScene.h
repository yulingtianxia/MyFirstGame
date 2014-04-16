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
#import "AtomNode.h"
#import "VisitablePhysicsBody.h"
@interface PlayFieldScene : SKScene <SKPhysicsContactDelegate>
@property AtomNode *touchedAtom;
@property SKNode * debugOverlay;
@property bool isPanningAtom;
@property bool isAllAtomStatic;
@end
