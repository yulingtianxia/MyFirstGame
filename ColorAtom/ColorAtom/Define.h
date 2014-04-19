//
//  Define.h
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-11.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#ifndef ColorAtom_Define_h
#define ColorAtom_Define_h

static CGFloat const ZERO  = 0.5;
static CGFloat const AtomRadius = 30;

static NSString const *AtomName = @"atom";
static NSString const *AtomPlusName = @"atomplus";
static NSString const *AtomMinusName = @"atomminus";
static NSString const *PlayFieldName = @"playfield";
static NSString const *DisplayScreenName = @"displayscreen";

static NSString const *ATOMCOLOR = @"atomcolor";

static CGFloat const AtomPlusVx = 0;
static CGFloat const AtomPlusVy = 1000;
static CGFloat const AtomMinusVx = 100;
static CGFloat const AtomMinusVy = -1000;

static CGFloat const AtomPlusCreateInterval = 0.5;
static CGFloat const AtomMinusCreateInterval = 1;

static NSString const *CreateAtomPlus = @"createatomplus";

#endif
