//
//  EffectButton.m
//  Nodes
//
//  Created by 杨萧玉 on 14-5-4.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "EmitterButton.h"

@implementation EmitterButton
-(id)init{
    if (self = [super initWithName:@"SKEmitterNode"]) {
        NSString *firePath = [[NSBundle mainBundle] pathForResource:@"MyParticle" ofType:@"sks"];
        self.node = [NSKeyedUnarchiver unarchiveObjectWithFile:firePath];
    }
    return self;
}
@end
