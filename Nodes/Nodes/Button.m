//
//  SceneButton.m
//  Physics
//
//  Created by 杨萧玉 on 14-5-4.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "Button.h"

@implementation Button
@synthesize choose;
@synthesize node;
@synthesize circle;
-(id)initWithName:(NSString *)name{
    if (self = [super init]) {
        self.text = name;
        self.fontSize = 20;
        self.fontColor = [UIColor blackColor];
        self.userInteractionEnabled = YES;
        node = [self createInstanceByClassName:self.text];
        node.alpha = 0.8;
        choose = NO;
        circle = [[SKShapeNode alloc] init];
    }
    return self;
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (!choose) {
        choose = YES;
        node.position = CGPointMake(CGRectGetMidX(self.parent.frame), CGRectGetMidY(self.parent.frame));
        [self.parent addChild:node];
        [self.delegate drawOriginal:self];
    }
    else{
        choose = NO;
        [node removeFromParent];
        [self.delegate eraseOriginal:self];
    }
    
}
- (id) createInstanceByClassName: (NSString *)className {
    Class aClass = NSClassFromString(className);
    id anInstance = [[aClass alloc] init];
    return anInstance;
}
@end
