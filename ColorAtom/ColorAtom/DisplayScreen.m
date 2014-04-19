//
//  DisplayScreen.m
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-19.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "DisplayScreen.h"
#import "Define.h"
@implementation DisplayScreen
@synthesize atomCount;
@synthesize score;
@synthesize atomCountLabel;
@synthesize scoreLabel;
-(id)init{
    if (self = [super init]) {
        self.name = (NSString *)DisplayScreenName;
        atomCount = 10;
        score = 0;
        atomCountLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        atomCountLabel.fontSize = 20;
        scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        scoreLabel.fontSize = 20;
        atomCountLabel.text = [NSString stringWithFormat:@"+Energy Left:%ld",(long)atomCount];
        scoreLabel.text = [NSString stringWithFormat:@"Score:%ld",(long)score];
        [self addChild:atomCountLabel];
        [self addChild:scoreLabel];
    }
    return self;
    
}
-(void)setPosition{
    self.size = CGSizeMake(self.scene.size.width, self.scene.size.height-AtomRadius*2);
    self.position = CGPointMake(self.scene.size.width/2, self.scene.size.height/2+AtomRadius);
    atomCountLabel.position = CGPointMake(-self.size.width/2+atomCountLabel.frame.size.width/2, -self.size.height/2+atomCountLabel.frame.size.height/2);
    scoreLabel.position = CGPointMake(0, self.size.height/2-scoreLabel.frame.size.height);


}
-(void)AtomMinusKilled{
    atomCount+=2;
    score+=10;
    atomCountLabel.text = [NSString stringWithFormat:@"+Energy Left:%ld",(long)atomCount];
    scoreLabel.text = [NSString stringWithFormat:@"Score:%ld",(long)score];
}

-(void)AtomPlusUsed{
    atomCount--;
    score+=5;
    atomCountLabel.text = [NSString stringWithFormat:@"+Energy Left:%ld",(long)atomCount];
    scoreLabel.text = [NSString stringWithFormat:@"Score:%ld",(long)score];
}
@end
