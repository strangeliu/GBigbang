//
//  GTagFlowContainer.m
//  GBigbang
//
//  Created by GIKI on 2017/10/20.
//  Copyright © 2017年 GIKI. All rights reserved.
//

#import "GTagFlowContainer.h"
#import "GTagCollectionViewLayout.h"

@interface GTagFlowContainer ()

@property (nonatomic, assign) BOOL useCustomLayout;
@property (nonatomic, strong) UIView *menuBackgroundView;
@property (nonatomic, strong) GTagFlowView *flowView;
@property (nonatomic, strong) UIView *topContentView;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, assign) CGFloat  maxFlowViewHeight;

@end

@implementation GTagFlowContainer

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self loadUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadUI];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hide) name:kGPopContainerHiddenKey object:nil];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _menuBackgroundView.frame = self.bounds;
    self.maxFlowViewHeight = self.bounds.size.height - 70 - 90;
    self.flowView.frame = CGRectMake(0,75 , self.frame.size.width, self.maxFlowViewHeight);
    self.closeBtn.frame = CGRectMake((self.frame.size.width - 50)/2, CGRectGetMaxY(self.flowView.frame) + 20, 50, 25);
    self.topContentView.frame = CGRectMake(0, CGRectGetMinY(self.flowView.frame)-50, self.frame.size.width, 40);
}

- (void)relodLayoutWithCollectionHeight:(CGFloat)height {
    if (height < self.maxFlowViewHeight) {
        self.flowView.frame = CGRectMake(0,([UIScreen mainScreen].bounds.size.height - height)/2 , self.frame.size.width, height);
    } else {
        self.flowView.frame = CGRectMake(0,75 , self.frame.size.width, self.maxFlowViewHeight);
    }
    self.closeBtn.frame = CGRectMake((self.frame.size.width - 50)/2, CGRectGetMaxY(self.flowView.frame) + 20, 50, 25);
    self.topContentView.frame = CGRectMake(0, CGRectGetMinY(self.flowView.frame)-50, self.frame.size.width, 40);
}

- (void)loadUI {
    self.frame = CGRectMake(0, 0, 100, 100);
    self.maxFlowViewHeight = self.bounds.size.height - 70 - 90;
    
    self.flowView = [[GTagFlowView alloc] init];
    __weak typeof(self) weakSelf = self;
    self.flowView.heightChangedBlock = ^(CGFloat original, CGFloat newHeight) {
        [weakSelf relodLayoutWithCollectionHeight:newHeight];
    };
    self.flowView.selectedChangedBlock = ^(BOOL hasSelected) {
        weakSelf.topContentView.hidden = !hasSelected;
    };
    
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *close = [self drawCloseImageSize:CGSizeMake(10, 10) lineWidth:1 tintColor:nil];
    [self.closeBtn setImage:close forState:UIControlStateNormal];
    self.closeBtn.layer.cornerRadius = 4;
    self.closeBtn.layer.masksToBounds = YES;
    self.closeBtn.backgroundColor = [UIColor blackColor];
    [self.closeBtn addTarget:self action:@selector(closeContanier:) forControlEvents:UIControlEventTouchUpInside];
    
    self.topContentView = [UIView new];
    self.topContentView.hidden = YES;
    
    [self addSubview:self.menuBackgroundView];
    [self addSubview:self.flowView];
    [self addSubview:self.closeBtn];
    [self addSubview:self.topContentView];
    self.actionBtnItems = @[@"复制", @"", @"翻译", @"搜索", @"分享"];
}

- (UIButton *)createTopButton:(NSString*)title frame:(CGRect)rect {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.contentEdgeInsets = UIEdgeInsetsMake(5, 10, 5, 10);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 4;
    btn.layer.masksToBounds = YES;
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    btn.frame = rect;
    btn.autoresizingMask = UIViewAutoresizingNone;
    [btn addTarget:self action:@selector(actionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor blackColor];
    [self.topContentView addSubview:btn];
    return btn;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - public method

- (void)setActionBtnItems:(NSArray<NSString *> *)actionBtnItems {
    _actionBtnItems = actionBtnItems;
    if (actionBtnItems.count > 0) {
        CGFloat totalWidth = 0;
        CGFloat padding = 10;
        CGFloat leftMargin = 10;
        [self.topContentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        for (NSInteger index = 0; index < actionBtnItems.count; index ++) {
            NSString *title = actionBtnItems[index];
            CGRect rect = CGRectMake(leftMargin + totalWidth + padding * index, 10, 0, 0);
            if (title.length > 0) {
                UIButton *button = [self createTopButton:title frame:rect];
                [button sizeToFit];
                totalWidth += button.bounds.size.width;
            }
        }
    }
}

- (void)configDatas:(NSArray*)flowDatas {
    self.flowView.flowDatas = flowDatas;
    [self relodLayoutWithCollectionHeight:self.maxFlowViewHeight];
    [self.flowView reloadDatas];
    [self setNeedsLayout];
}

- (void)hide {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

#pragma mark - private method

- (void)closeContanier:(UIButton*)btn {
    NSArray * array = [self.flowView filterAllSelectTitles];
    if (array.count>0) {
        [self.flowView.flowDatas makeObjectsPerformSelector:@selector(setIsSelected:) withObject:@(NO)];
        self.topContentView.hidden = YES;
        [self.flowView reloadDatas];
    } else {
        [self hide];
    }
}

- (void)actionBtnClick:(UIButton*)btn {
    [self hide];
    NSString * text = [self.flowView getNewTextstring];
    if ([btn.titleLabel.text isEqualToString:@"复制"]) {
        [self copyText:text];
    } else if ([btn.titleLabel.text isEqualToString:@"翻译"]) {
        
    } else if ([btn.titleLabel.text isEqualToString:@"搜索"]) {
        
    } else if ([btn.titleLabel.text isEqualToString:@"分享"]) {
        
    }
    if (self.actionBlock) {
        self.actionBlock(btn.titleLabel.text, text);
    }
}

- (void)copyText:(NSString*)text {
    if (text.length > 0) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:text];
    }
}

- (UIView *)menuBackgroundView {
    if (!_menuBackgroundView) {
        _menuBackgroundView = [[UIView alloc] init];
        _menuBackgroundView.frame = CGRectMake(0, 0, 100 , 100);
        if ([UIDevice currentDevice].systemVersion.floatValue > 7.99f) {
            UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
            UIVisualEffectView *effectV = [[UIVisualEffectView alloc] initWithEffect:effect];
            effectV.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [_menuBackgroundView addSubview:effectV];
            effectV.frame = _menuBackgroundView.frame;
        } else {
            _menuBackgroundView.backgroundColor = [UIColor blackColor];
        }
    }
    return _menuBackgroundView;
}

- (UIImage*)drawCloseImageSize:(CGSize)size lineWidth:(CGFloat)lineWidth tintColor:(UIColor *)tintColor {
    UIImage *resultImage = nil;
    tintColor = tintColor ? tintColor : [UIColor whiteColor];
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(size.width, size.height)];
    [path closePath];
    [path moveToPoint:CGPointMake(size.width, 0)];
    [path addLineToPoint:CGPointMake(0, size.height)];
    [path closePath];
    path.lineWidth = lineWidth;
    path.lineCapStyle = kCGLineCapRound;
    CGContextSetStrokeColorWithColor(context, tintColor.CGColor);
    [path stroke];
    resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

@end
