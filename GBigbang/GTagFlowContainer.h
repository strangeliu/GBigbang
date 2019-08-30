//
//  GTagFlowContainer.h
//  GBigbang
//
//  Created by GIKI on 2017/10/20.
//  Copyright © 2017年 GIKI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTagFlowView.h"
#import "GBigbangAction.h"

#define kGPopContainerHiddenKey @"kGPopContainerHiddenKey"

typedef void(^GTagFlowActionBlock) (NSString *actionTitle, NSString*newText);

@interface GTagFlowContainer : UIView

@property (nonatomic, strong) NSArray<GBigbangAction *> *actions;
@property (nonatomic, copy) void(^cancelBlock)(void);

@property (nonatomic, strong, readonly) GTagFlowView *flowView;

- (void)configDatas:(NSArray<GTagFlowItem *> *)flowDatas;

@end


