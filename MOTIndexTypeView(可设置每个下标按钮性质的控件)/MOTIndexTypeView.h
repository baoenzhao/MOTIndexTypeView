//
//  MOTCameraUpIndexView.h
//
//
//  Created by orztech on 17/6/26.
//
//

#import <UIKit/UIKit.h>

@protocol MOTIndexTypeViewDelegate <NSObject>

@optional
//单选模式下选择了第几个
- (void)didSelectedByRadioTypeWithIndex:(NSInteger) index;

//点击了第几个
- (void)didTappedWithIndex:(NSInteger) index;

//当是多选模式的情况下触发，或者代码控制单个按钮的选中状态也会触发
- (void)didSeleted:(BOOL) selected Index:(NSInteger) index;

@end

@interface MOTIndexTypeView : UIView

@property (assign, nonatomic) id <MOTIndexTypeViewDelegate>delegate;

//设定图片的Size，默认20
@property (assign, nonatomic) CGSize imageSize;

//是否设置多选模式，默认否为单选模式
@property (assign, nonatomic) BOOL isCheck;

//正常状态图片名称数组，只有设置了这个才有按钮出现
@property (strong, nonatomic) NSArray <NSString*>*imageNameArray;

//选中状态的图片名称数组，只有当设置了imageNameArray才有效
@property (strong, nonatomic) NSArray <NSString*>*selectedImageNameArray;

//不可用状态的图片名称数组，只有当设置了imageNameArray才有效
@property (strong, nonatomic) NSArray <NSString*>*disabledImageNameArray;

//高亮状态的图片名称数组，只有当设置了imageNameArray才有效
@property (strong, nonatomic) NSArray <NSString*>*highlightedImageNameArray;

//添加边框横线
@property (assign, nonatomic) BOOL topLine;
@property (assign, nonatomic) BOOL bottomLine;
@property (assign, nonatomic) BOOL leftLine;
@property (assign, nonatomic) BOOL rightLine;
//默认浅灰色
@property (strong, nonatomic) UIColor *lineColor;

//通过下标设置某个按钮的是否可用
- (void)setOneButtonWithEnabled:(BOOL) enabled Index:(NSInteger) index;

//通过下标设置某个按钮的选择状态
- (void)setOneButtonWithSelected:(BOOL) selected Index:(NSInteger) index;

//设置所有按钮的可用状态
- (void)setAllButtonWithEnabled:(BOOL) enabled;
//设置所有按钮的选择状态
- (void)setAllButtonWithSelected:(BOOL) selected;

//通过下标设置为单个按钮多选模式
- (void)setCheckTypeWithIndex:(NSInteger) index;

//通过下标设置为单个按钮单选模式
- (void)setRadioTypeWithIndex:(NSInteger) index;

//通过下标设置为单个按钮的点击模式
- (void)setTapTypeWithIndex:(NSInteger) index;

//通过下标取消单个按钮的点击模式
- (void)cancelTapTypeWithIndex:(NSInteger) index;

@end
