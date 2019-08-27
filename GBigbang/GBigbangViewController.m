//
//  GBigbangViewController.m
//  GBigbangExample
//
//  Created by liu on 2019/8/23.
//  Copyright © 2019 GIKI. All rights reserved.
//

#import "GBigbangViewController.h"
#import "GTagFlowContainer.h"

@interface GBigbangViewController ()

@property (nonatomic, strong) GTagFlowContainer *containerView;

@end

@implementation GBigbangViewController

- (instancetype)initWithItems:(NSArray<GTagFlowItem *> *)items {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.items = items;
        self.containerView = [[GTagFlowContainer alloc] init];
    }
    return self;
}

- (void)loadView {
    self.view = self.containerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    GTagFlowContainer *view = (GTagFlowContainer *)self.view;
    [view configDatas:self.items];
    __weak typeof(self) weakSelf = self;
    view.cancelBlock = ^{
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
}

@end
