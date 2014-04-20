//
//  DisplayScreen.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-19.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "DisplayScreen.h"
#import "Define.h"
#import "GameOverScene.h"
@implementation DisplayScreen
@synthesize atomCount;
@synthesize score;
@synthesize rank;
@synthesize atomCountLabel;
@synthesize scoreLabel;
@synthesize rankLabel;

-(id)init{
    if (self = [super init]) {
        self.name = (NSString *)DisplayScreenName;
        atomCount = 10;
        score = 0;
        atomCountLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        atomCountLabel.fontSize = 20;
        scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        scoreLabel.fontSize = 20;
        rankLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        rankLabel.fontSize = 20;
        atomCountLabel.text = [NSString stringWithFormat:@"+Energy Left:%ld",(long)atomCount];
        scoreLabel.text = [NSString stringWithFormat:@"Score:%ld",(long)score];
        rankLabel.text = [NSString stringWithFormat:@"Rank:%ld",(long)rank];
        [self addChild:atomCountLabel];
        [self addChild:scoreLabel];
        [self addChild:rankLabel];
    }
    return self;
    
}
-(void)setPosition{
    self.size = CGSizeMake(self.scene.size.width, self.scene.size.height-AtomRadius*2);
    self.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2+AtomRadius);
    atomCountLabel.position = CGPointMake(-self.size.width/2+atomCountLabel.frame.size.width/2, -self.size.height/2+atomCountLabel.frame.size.height/2);
    scoreLabel.position = CGPointMake(0, self.size.height/2-scoreLabel.frame.size.height);
    rankLabel.position = CGPointMake(self.size.width/2-rankLabel.frame.size.width/2, -self.size.height/2+rankLabel.frame.size.height/2);

}
-(void)AtomMinusKilled{
    atomCount+=3;
    score+=10;
    atomCountLabel.text = [NSString stringWithFormat:@"+Energy Left:%ld",(long)atomCount];
    scoreLabel.text = [NSString stringWithFormat:@"Score:%ld",(long)score];
    rankLabel.text = [NSString stringWithFormat:@"Rank:%ld",(long)rank];
    [self gameCheck];
}

-(void)AtomPlusUsed:(NSInteger) num{
    atomCount-=num;
    score+=5*num;
    atomCountLabel.text = [NSString stringWithFormat:@"+Energy Left:%ld",(long)atomCount];
    scoreLabel.text = [NSString stringWithFormat:@"Score:%ld",(long)score];
    rankLabel.text = [NSString stringWithFormat:@"Rank:%ld",(long)rank];
    [self gameCheck];
}

-(void)AtomMinusAttacked{
    atomCount-=10*rank;
    atomCountLabel.text = [NSString stringWithFormat:@"+Energy Left:%ld",(long)atomCount];
    [self gameCheck];
}

-(void)gameCheck{
    if (atomCount<=0) {
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        SKScene * gameOverScene = [[GameOverScene alloc] initWithSize:self.scene.size Score:score];
        [self.scene.view presentScene:gameOverScene transition: reveal];
    }
}
@end
