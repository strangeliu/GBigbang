//
//  GBigbangAction.m
//  GBigbangExample
//
//  Created by liu on 2019/8/30.
//  Copyright © 2019 GIKI. All rights reserved.
//

#import "GBigbangAction.h"

@implementation GBigbangAction

- (instancetype)initWithTitle:(NSString *)title action:(GTagFlowActionBlock)action {
    self = [super init];
    if (self) {
        self.title = title;
        self.action = action;
    }
    return self;
}

@end
