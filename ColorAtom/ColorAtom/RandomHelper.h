//
//  RandomHelper.h
//  ColorAtom
//
//  Created by 杨萧玉 on 14-4-12.
//  Copyright (c) 2014年 杨萧玉. All rights reserved.
//

#ifndef ColorAtom_RandomHelper_h
#define ColorAtom_RandomHelper_h

static inline CGFloat skRandf() {
    return rand()/(CGFloat)RAND_MAX;
}

static inline CGFloat skRand(CGFloat low, CGFloat high) {
    return skRandf()*(high - low) + low;
}

#endif
