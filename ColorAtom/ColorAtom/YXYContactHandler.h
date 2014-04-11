//
//  YXYContactHandler.h
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-11.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
@protocol YXYContactHandler <NSObject>
-(void)NodeA:(SKNode *)nodeA didCollideWithNodeB:(SKNode *)nodeB;
@end
