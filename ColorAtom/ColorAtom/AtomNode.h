//
//  YXYAtomNode.h
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-12.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Define.h"
#import "RandomHelper.h"
#import "NodeCategories.h"
@interface AtomNode : SKSpriteNode
@property UInt32 category;
- (id)initWithName:(NSString *)name;
-(void) changeColorWithAtom:(AtomNode *) atom;
-(void) displayColor;
@end
