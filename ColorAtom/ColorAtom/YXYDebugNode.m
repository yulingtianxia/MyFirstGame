//
//  YXYDebugNode.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-12.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "YXYDebugNode.h"

@implementation YXYDebugNode
@synthesize label;
-(id)init
{
    if (self=[super init]) {
        label = [SKLabelNode node];
        [label setFontColor:[UIColor whiteColor]];
        [self addChild:label];
    }
    return self;
}
@end
