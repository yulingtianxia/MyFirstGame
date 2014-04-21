//
//  YXYAtomNode.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-12.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "AtomNode.h"

@implementation AtomNode
-(id)init
{
    return [self initWithName:AtomName];
}
-(id)initWithName:(NSString *)name
{
    self = [super initWithTexture:[SKTexture textureWithImageNamed:@"Atom"] color:[SKColor colorWithRed:skRandf() green:skRandf() blue:skRandf() alpha:1] size:CGSizeMake(AtomRadius*2, AtomRadius*2)];
    self.colorBlendFactor = 1.0;
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:AtomRadius];
    self.physicsBody.dynamic = YES;
    self.physicsBody.categoryBitMask = AtomCategory;
    self.physicsBody.contactTestBitMask = AtomCategory|PlayFieldCategory;
    self.physicsBody.linearDamping = 0.8;
    self.name = AtomName;
    return self;
}
@end
