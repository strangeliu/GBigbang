//
//  GBigbangAction.h
//  GBigbangExample
//
//  Created by liu on 2019/8/30.
//  Copyright © 2019 GIKI. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^GTagFlowActionBlock) (NSString * _Nonnull actionTitle, NSString * _Nonnull newText);

NS_ASSUME_NONNULL_BEGIN

@interface GBigbangAction : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, copy) GTagFlowActionBlock action;

- (instancetype)initWithTitle:(NSString *)title action:(GTagFlowActionBlock)action;

@end

NS_ASSUME_NONNULL_END
