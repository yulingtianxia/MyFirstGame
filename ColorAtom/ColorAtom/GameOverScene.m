//
//  YXYGameOverScene.m
//  MyFirstGame
//
//  Created by 杨萧玉 on 14-3-23.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "GameOverScene.h"
#import "PlayFieldScene.h"
@implementation GameOverScene
@synthesize background;
-(id)initWithSize:(CGSize)size Score:(NSInteger) score{
    if (self = [super initWithSize:size]) {
        
        self.backgroundColor = [SKColor clearColor];
        SKLabelNode *gameover = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        gameover.text = @"GAME OVER";
        gameover.fontSize = 40;
        gameover.fontColor = [SKColor whiteColor];
        gameover.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:gameover];
        scoreLabel.text = [NSString stringWithFormat:@"SCORE:%ld",(long)score];
        scoreLabel.fontSize = 40;
        scoreLabel.fontColor = [SKColor whiteColor];
        scoreLabel.position = CGPointMake(self.size.width/2, self.size.height/4);
        [self addChild:scoreLabel];
        background = [[Background alloc] init];
        background.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:background];
        [self runAction:
         [SKAction sequence:@[
                              [SKAction waitForDuration:5],
                              [SKAction runBlock:^{
             // 5
             SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
             SKScene * myScene = [[PlayFieldScene alloc] initWithSize:self.size];
             [self.view presentScene:myScene transition: reveal];
         }]
                              ]]
         ];
        
    }
    return self;
}
@end
