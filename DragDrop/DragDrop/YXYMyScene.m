//
//  YXYMyScene.m
//  DragDrop
//
//  Created by 杨萧玉 on 14-3-26.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#import "YXYMyScene.h"

@implementation YXYMyScene
@synthesize background;
@synthesize selectedNode;
-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        background = [SKSpriteNode spriteNodeWithImageNamed:@"blue-shooting-stars"];
        [background setName:@"background"];
        [background setAnchorPoint:CGPointZero];
        
        [self addChild:background];
        
        
        NSArray *imageNames = @[@"bird", @"cat", @"dog", @"turtle"];
        for(int i = 0; i < [imageNames count]; ++i) {
            NSString *imageName = [imageNames objectAtIndex:i];
            SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:imageName];
            [sprite setName:kAnimalNodeName];
            
            float offsetFraction = ((float)(i + 1)) / ([imageNames count] + 1);
            [sprite setPosition:CGPointMake(size.width * offsetFraction, size.height / 2)];
            [background addChild:sprite];
        }
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    [self selectNodeForTouch:positionInScene];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint positionInScene = [touch locationInNode:self];
	CGPoint previousPosition = [touch previousLocationInNode:self];
    
	CGPoint translation = CGPointMake(positionInScene.x - previousPosition.x, positionInScene.y - previousPosition.y);
    
	[self panForTranslation:translation];
}
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

- (void)selectNodeForTouch:(CGPoint)touchLocation {
    //1
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchLocation];
    
    //2
	if(![selectedNode isEqual:touchedNode]) {
		[selectedNode removeAllActions];
		[selectedNode runAction:[SKAction rotateToAngle:0.0f duration:0.1]];
        
		selectedNode = touchedNode;
		//3
		if([[touchedNode name] isEqualToString:kAnimalNodeName]) {
			SKAction *sequence = [SKAction sequence:@[[SKAction rotateByAngle:degToRad(-4.0f) duration:0.1],
													  [SKAction rotateByAngle:0.0 duration:0.1],
													  [SKAction rotateByAngle:degToRad(4.0f) duration:0.1]]];
			[selectedNode runAction:[SKAction repeatActionForever:sequence]];
		}
	}
    
}

float degToRad(float degree) {
	return degree / 180.0f * M_PI;
}
- (CGPoint)boundLayerPos:(CGPoint)newPos {
    CGSize winSize = self.size;
    CGPoint retval = newPos;
    retval.x = MIN(retval.x, 0);
    retval.x = MAX(retval.x, -[background size].width+ winSize.width);
    retval.y = [self position].y;
    return retval;
}

- (void)panForTranslation:(CGPoint)translation {
    CGPoint position = [selectedNode position];
    if([[selectedNode name] isEqualToString:kAnimalNodeName]) {
        [selectedNode setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];
    } else {
        CGPoint newPos = CGPointMake(position.x + translation.x, position.y + translation.y);
        [background setPosition:[self boundLayerPos:newPos]];
    }
}
@end
