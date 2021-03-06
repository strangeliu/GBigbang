# GBigbang
大爆炸/分词/TagFlowView
==============

[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/GIKICoder/GBigbang/blob/master/LICENSE)&nbsp;
[![Support](https://img.shields.io/badge/support-iOS7+-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/v/GBigbang.svg?style=flat)](http://cocoapods.org/pods/GBigbang)&nbsp;

介绍
==============
这是一个分词组件.用与文本分词,列表展示.参考Pin的分词界面.和UC的bigbang界面.
(该项目是 [GRichLabel](https://github.com/GIKICoder/GRichLabel) 文本选择复制功能的组件之一).欢迎大家star!


特性
==============
- 可区分标点符号与表情.
- 可自定义分词展现列表.
- 分词列表支持滑动/点击选择.
- 提供默认分词展现Container.

用法
==============

###  区分标点符号与表情
```objc

-(void)bigbang:(NSString*)selection
{
    NSArray * array = [GBigbangBox bigBang:selection];
    __block NSMutableArray *flows = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(GBigbangItem  * obj, NSUInteger idx, BOOL * _Nonnull stop) {
    GTagFlowItem *layout = [GTagFlowItem tagFlowItemWithText:obj.text];
        [flows addObject:layout];
        if (obj.isSymbolOrEmoji) {
            layout.appearance.backgroundColor = [UIColor grayColor];
            layout.appearance.textColor = [UIColor blackColor];
        }
    }];
    [self.container configDatas:flows.copy];
    [self.container show];
}

```
###  自定义分词展示列表样式
```objc
    self.appearance = [GTagFlowAppearance new];
    self.appearance.borderColor = [UIColor blackColor];
    self.appearance.textColor = [UIColor blackColor];
    self.appearance.borderWidth = 1;
    self.appearance.backgroundColor = [UIColor whiteColor];
    self.appearance.selectTextColor = [UIColor redColor];
    self.appearance.selectBorderColor = [UIColor redColor];
    self.appearance.selectBackgroundColor = [UIColor whiteColor];

    NSArray *items = [GBigbangBox bigBang:self.string];

    NSArray * layouts = [GTagFlowItem factoryFolwLayoutWithItems:items withAppearance:self.appearance];
    self.flowView.flowDatas = layouts;
    [self.flowView reloadDatas];
```
###  分词列表 使用自定义流水布局
```objc
    GTagFlowContainer *container = [GTagFlowContainer new];
    self.container = container;
    /// 使用自定义流水布局
    [self.container.flowView configTagCollectionViewLayout];
    self.container.actionBtnItems = @[@"复制",@"举报",@"错别字"];
    self.container.actionBlock = ^(NSString *actionTitle, NSString *newText) {
        NSLog(@"点击了 -- %@, 选择的文字 -- %@",actionTitle,newText);
    };
    
    NSArray * layouts = [GTagFlowItem factoryFolwLayoutWithItems:items withAppearance:nil];
    self.flowView.flowDatas = layouts;
    [self.flowView reloadDatas];
```
安装
==============
### CocoaPods

1. Add `pod 'GBigbang'` to your Podfile.
2. Run `pod install` or `pod update`.
3. Import "GBigbang.h"

### 手动添加
1. ` git clone  https://github.com/GIKICoder/GBigbang.git `
2. 选择`GBigbang`文件夹.拖入项目中即可.

更新
==============
- 2017/11/24 : 增加自定义布局Layout. bigbang列表可使用自定义布局. 实现固定间距列表.

Demo
==============
### Demo

<img src="https://github.com/GIKICoder/GBigbang/blob/master/snapshot/bigbangDemo1.gif" width="320">
<img src="https://github.com/GIKICoder/GBigbang/blob/master/snapshot/bigbangDemo2.gif" width="320">
<img src="https://github.com/GIKICoder/GBigbang/blob/master/snapshot/demo3.png" width="320">
<img src="https://github.com/GIKICoder/GBigbang/blob/master/snapshot/demo4.png" width="320">

