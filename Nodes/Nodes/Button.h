//
//  SceneButton.h
//  Physics
//
//  Created by 杨萧玉 on 14-5-4.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@class Button;
@protocol original <NSObject>

-(void)drawOriginal:(Button *) button;

-(void)eraseOriginal:(Button *) button;

@end

@interface Button : SKLabelNode
@property Boolean choose;
@property SKNode *node;
@property SKShapeNode * circle;
@property (weak,nonatomic) id<original> delegate;
-(id)initWithName:(NSString *)name;
@end

