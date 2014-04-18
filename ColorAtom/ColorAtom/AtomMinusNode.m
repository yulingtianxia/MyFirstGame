//
//  AtomMinusNode.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-18.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "AtomMinusNode.h"

@implementation AtomMinusNode
-(id)init
{
    if (self = [super initWithName:AtomPlusName ImageName:@"Atomminus"]) {
        self.physicsBody.categoryBitMask = AtomMinusCategory;
    }
    return self;
}
@end
