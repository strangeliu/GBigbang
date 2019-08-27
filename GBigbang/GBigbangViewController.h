//
//  GBigbangViewController.h
//  GBigbangExample
//
//  Created by liu on 2019/8/23.
//  Copyright © 2019 GIKI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTagFlowItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface GBigbangViewController : UIViewController

@property(nonatomic, strong) NSArray<GTagFlowItem *> *items;

- (instancetype)initWithItems:(NSArray<GTagFlowItem *> *)items; NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
