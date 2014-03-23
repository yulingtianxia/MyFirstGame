//
//  YXYGameOverScene.m
//  MyFirstGame
//
//  Created by 杨萧玉 on 14-3-23.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "YXYGameOverScene.h"
#import "YXYMyScene.h"
@implementation YXYGameOverScene
-(id)initWithSize:(CGSize)size won:(BOOL)won {
    if (self = [super initWithSize:size]) {
        
        // 1
        self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        // 2
        NSString * message;
        NSString * author = @"By yulingtianxia";
        if (won) {
            message = @"You Won!";
        } else {
            message = @"You Lose :(";
        }
        
        // 3
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        label.text = message;
        label.fontSize = 40;
        label.fontColor = [SKColor blackColor];
        label.position = CGPointMake(self.size.width/2, self.size.height/2);
        SKLabelNode *authorlabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        authorlabel.text = author;
        authorlabel.fontSize = 20;
        authorlabel.fontColor = [SKColor blackColor];
        authorlabel.position = CGPointMake(self.size.width-authorlabel.frame.size.width/2, authorlabel.frame.size.height/2);
        
        [self addChild:label];
        [self addChild:authorlabel];
        // 4
        [self runAction:
         [SKAction sequence:@[
                              [SKAction waitForDuration:3.0],
                              [SKAction runBlock:^{
             // 5
             SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
             SKScene * myScene = [[YXYMyScene alloc] initWithSize:self.size];
             [self.view presentScene:myScene transition: reveal];
         }]
                              ]]
         ];
        
    }
    return self;
}
@end
