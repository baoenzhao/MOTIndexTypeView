//
//  MOTCameraUpIndexView.m
//
//
//  Created by orztech on 17/6/26.
//
//

#import "MOTIndexTypeView.h"

@interface MOTIndexTypeButton : UIButton

@property (strong, nonatomic) UIImageView *buttonImageView;
@property (assign, nonatomic) CGSize imageSize;
@property (strong, nonatomic) UIImage *normalImage;
@property (strong, nonatomic) UIImage *selectedImage;
@property (strong, nonatomic) UIImage *disabledImage;
@property (strong, nonatomic) UIImage *highlightedImage;
@property (assign, nonatomic) BOOL isLine;
@property (assign, nonatomic) NSInteger index;
@property (assign, nonatomic) BOOL isCheck;
@property (assign, nonatomic) BOOL isTap;

@property (strong, nonatomic) NSLayoutConstraint *width;
@property (strong, nonatomic) NSLayoutConstraint *height;

@end

@implementation MOTIndexTypeButton

#pragma mark -懒加载
- (UIImageView *)buttonImageView {
    if (!_buttonImageView) {
        _buttonImageView = [UIImageView new];
        _buttonImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:_buttonImageView];
        [self addConstraint];
    }
    
    return _buttonImageView;
}

#pragma mark -系统方法
- (void)drawRect:(CGRect)rect {
    if (self.isLine) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        [path moveToPoint:CGPointMake(self.frame.size.width - 0.25, self.frame.size.height * 0.2)];
        [path addLineToPoint:CGPointMake(self.frame.size.width - 0.25, self.frame.size.height * 0.8)];
        path.lineWidth = 0.25;
        [[UIColor lightGrayColor] setStroke];
        [path stroke];
    }
}
- (void)layoutSubviews {
    [self setNeedsDisplay];
}

#pragma mark -setter方法
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if (selected) {
        self.buttonImageView.image = self.selectedImage;
    }
    else {
        self.buttonImageView.image = self.normalImage;
    }
}
- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    
    if (!enabled) {
        self.buttonImageView.image = self.disabledImage;
    }
    else {
        if ([self.buttonImageView.image isEqual:self.disabledImage]) {
            self.buttonImageView.image = self.normalImage;
        }
        else {
            self.buttonImageView.image = self.buttonImageView.image;
        }
    }
}
- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (self.isTap) {
        if (highlighted) {
            self.buttonImageView.image = self.highlightedImage;
        }
        else {
            self.buttonImageView.image = self.normalImage;
        }
    }
}
- (void)setNormalImage:(UIImage *)normalImage {
    _normalImage = normalImage;
    
    if (!self.selected) {
        self.buttonImageView.image = normalImage;
    }
}
- (void)setSelectedImage:(UIImage *)selectedImage {
    _selectedImage = selectedImage;
    
    if (self.selected) {
        self.buttonImageView.image = selectedImage;
    }
}
- (void)setDisabledImage:(UIImage *)disabledImage {
    _disabledImage = disabledImage;
    
    if (!self.enabled) {
        self.buttonImageView.image = disabledImage;
    }
}
- (void)setHighlightedImage:(UIImage *)highlightedImage {
    _highlightedImage = highlightedImage;
    
    if (self.highlighted) {
        self.buttonImageView.image = highlightedImage;
    }
}
- (void)setImageSize:(CGSize)imageSize {
    _imageSize = imageSize;
    
    self.width.constant = imageSize.width;
    self.height.constant = imageSize.height;
    
    [self setNeedsLayout];
}
- (void)setIsLine:(BOOL)isLine {
    _isLine = isLine;
    
    [self setNeedsDisplay];
}

#pragma mark -约束
- (void)addConstraint {
    self.buttonImageView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:self.buttonImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:self.buttonImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    self.width = [NSLayoutConstraint constraintWithItem:self.buttonImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:20];
    self.height = [NSLayoutConstraint constraintWithItem:self.buttonImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:20];
    
    [self addConstraints:@[centerX, centerY, self.height, self.width]];
}


@end

@interface MOTIndexTypeView ()

@property (strong, nonatomic) NSMutableArray *buttonArray;


@end

@implementation MOTIndexTypeView

#pragma mark -懒加载

#pragma mark -系统方法
- (void)drawRect:(CGRect)rect {
    
    UIColor *lineColor = self.lineColor ? self.lineColor : [UIColor lightGrayColor];
    
    if (self.topLine) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        [path moveToPoint:CGPointMake(0, 0.5)];
        [path addLineToPoint:CGPointMake(self.frame.size.width, 0.5)];
        path.lineWidth = 0.5;
        [lineColor setStroke];
        [path stroke];
    }
    
    if (self.bottomLine) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        [path moveToPoint:CGPointMake(0, self.frame.size.height - 0.5)];
        [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height - 0.5)];
        path.lineWidth = 0.5;
        [lineColor setStroke];
        [path stroke];
    }
    
    if (self.leftLine) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        [path moveToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(0, self.frame.size.height)];
        path.lineWidth = 0.5;
        [lineColor setStroke];
        [path stroke];
    }
    
    if (self.rightLine) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        [path moveToPoint:CGPointMake(self.frame.size.width - 0.5, 0)];
        [path addLineToPoint:CGPointMake(self.frame.size.width - 0.5, self.frame.size.height)];
        path.lineWidth = 0.5;
        [lineColor setStroke];
        [path stroke];
    }
}
- (void)layoutSubviews {
    [self setNeedsDisplay];
}

#pragma mark -setter方法
- (void)setImageNameArray:(NSArray<NSString *> *)imageNameArray {
    _imageNameArray = imageNameArray;
    
    if (!self.buttonArray) {
        self.isCheck = NO;
        self.buttonArray = [NSMutableArray array];
        
        for (int i = 0; i < imageNameArray.count; i++) {
            MOTIndexTypeButton *button = [MOTIndexTypeButton buttonWithType:UIButtonTypeCustom];
            button.index = i;
            button.normalImage = [UIImage imageNamed:imageNameArray[i]];
            button.isCheck = NO;
            [button addTarget:self action:@selector(clickFunction:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:button];
            [self.buttonArray addObject:button];
            
            button.translatesAutoresizingMaskIntoConstraints = NO;
            
            if (i == 0) {
                [self addFirstLeftConstraint:button];
                button.selected = YES;
                
                //初始化的选择为0
                if ([self.delegate respondsToSelector:@selector(didSelectedByRadioTypeWithIndex:)]) {
                    [self.delegate didSelectedByRadioTypeWithIndex:0];
                }
            }
            else if (i == imageNameArray.count - 1) {
                [self addLastRightConstraint:button];
            }
            else {
                button.selected = NO;
            }
            
            [self addSameConstraint:button];
        }
        
        if (self.buttonArray.count > 1) {
            for (int i = 0; i < self.buttonArray.count; i++) {
                MOTIndexTypeButton *button = self.buttonArray[i];
                
                if (i == 0) {
                    button.isLine = YES;
                    [self addFirstRightConstraintWithView1:button View2:self.buttonArray[i + 1]];
                }
                else if (i == self.buttonArray.count - 1) {
                    [self addLastLeftConstraintWithView1:button View2:self.buttonArray[i - 1]];
                }
                else {
                    button.isLine = YES;
                    [self addOtherConstraintWithView:button Index:i];
                }
            }
        }
    }
}
- (void)setSelectedImageNameArray:(NSArray<NSString *> *)selectedImageNameArray {
    _selectedImageNameArray = selectedImageNameArray;
    
    if (self.buttonArray) {
        for (int i = 0; i < selectedImageNameArray.count; i++) {
            if (i < self.buttonArray.count) {
                MOTIndexTypeButton *button = self.buttonArray[i];
                button.selectedImage = [UIImage imageNamed:selectedImageNameArray[i]];
            }
        }
    }
}
- (void)setHighlightedImageNameArray:(NSArray<NSString *> *)highlightedImageNameArray {
    _highlightedImageNameArray = highlightedImageNameArray;
    
    if (self.buttonArray) {
        for (int i = 0; i < highlightedImageNameArray.count; i++) {
            if (i < self.buttonArray.count) {
                MOTIndexTypeButton *button = self.buttonArray[i];
                button.highlightedImage = [UIImage imageNamed:highlightedImageNameArray[i]];
            }
        }
    }
}
- (void)setDisabledImageNameArray:(NSArray<NSString *> *)disabledImageNameArray {
    _disabledImageNameArray = disabledImageNameArray;
    
    if (self.buttonArray) {
        for (int i = 0; i < disabledImageNameArray.count; i++) {
            if (i < self.buttonArray.count) {
                MOTIndexTypeButton *button = self.buttonArray[i];
                button.disabledImage = [UIImage imageNamed:disabledImageNameArray[i]];
            }
        }
    }
}
- (void)setTopLine:(BOOL)topLine {
    _topLine = topLine;
    
    [self setNeedsDisplay];
}
- (void)setBottomLine:(BOOL)bottomLine {
    _bottomLine = bottomLine;
    
    [self setNeedsDisplay];
}
- (void)setLeftLine:(BOOL)leftLine {
    _leftLine = leftLine;
    
    [self setNeedsDisplay];
}
- (void)setRightLine:(BOOL)rightLine {
    _rightLine = rightLine;
    
    [self setNeedsDisplay];
}
- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    
    [self setNeedsDisplay];
}
- (void)setIsCheck:(BOOL)isCheck {
    _isCheck = isCheck;
    
    if (isCheck) {
        for (MOTIndexTypeButton *button in self.buttonArray) {
            button.isCheck = YES;
            button.isTap = NO;
            if (button.enabled) {
                button.selected = NO;
            }
        }
    }
    else {
        for (int i = 0; i < self.buttonArray.count; i++) {
            MOTIndexTypeButton *button = self.buttonArray[i];
            button.isCheck = NO;
            button.isTap = NO;
            if (i == 0) {
                button.selected = YES;
                
                if ([self.delegate respondsToSelector:@selector(didSelectedByRadioTypeWithIndex:)]) {
                    [self.delegate didSelectedByRadioTypeWithIndex:0];
                }
            }
        }
    }
}

#pragma mark -getter方法

#pragma mark -初始化方法

#pragma mark -约束
- (void)addSameConstraint:(UIView*) view {
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    [self addConstraints:@[top, bottom]];
}
- (void)addFirstLeftConstraint:(UIView*) view {
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    
    [self addConstraint:left];
}
- (void)addLastRightConstraint:(UIView*) view {
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    
    [self addConstraint:right];
}
- (void)addFirstRightConstraintWithView1:(UIView*) view1 View2:(UIView*) view2 {
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    
    [self addConstraints:@[right, width]];
}
- (void)addLastLeftConstraintWithView1:(UIView*) view1 View2:(UIView*) view2 {
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:view1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view2 attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    
    [self addConstraints:@[left, width]];
}
- (void)addOtherConstraintWithView:(UIView*) view Index:(NSInteger) i {
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.buttonArray[i - 1] attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.buttonArray[i + 1] attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.buttonArray[i + 1] attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    
    [self addConstraints:@[left, right, width]];
}

#pragma mark -公共方法
- (void)setOneButtonWithEnabled:(BOOL)enabled Index:(NSInteger)index {
    if (index < self.buttonArray.count) {
        MOTIndexTypeButton *button = self.buttonArray[index];
        button.enabled = enabled;
    }
}
- (void)setOneButtonWithSelected:(BOOL)selected Index:(NSInteger)index {
    if (index < self.buttonArray.count) {
        MOTIndexTypeButton *button = self.buttonArray[index];
        button.selected = selected;
        if ([self.delegate respondsToSelector:@selector(didSeleted:Index:)]) {
            [self.delegate didSeleted:selected Index:index];
        }
    }
}
- (void)setAllButtonWithEnabled:(BOOL)enabled {
    for (MOTIndexTypeButton *button in self.buttonArray) {
        button.enabled = enabled;
    }
}
- (void)setAllButtonWithSelected:(BOOL)selected {
    for (MOTIndexTypeButton *button in self.buttonArray) {
        button.selected = selected;
    }
}

- (void)setCheckTypeWithIndex:(NSInteger)index {
    if (index < self.buttonArray.count) {
        MOTIndexTypeButton *button = self.buttonArray[index];
        button.isCheck = YES;
        button.isTap = NO;
    }
}
- (void)setRadioTypeWithIndex:(NSInteger)index {
    if (index < self.buttonArray.count) {
        MOTIndexTypeButton *button = self.buttonArray[index];
        button.isCheck = NO;
        button.isTap = NO;
    }
}
- (void)setTapTypeWithIndex:(NSInteger)index {
    if (index < self.buttonArray.count) {
        MOTIndexTypeButton *button = self.buttonArray[index];
        button.isTap = YES;
        button.selected = NO;
    }
}
- (void)cancelTapTypeWithIndex:(NSInteger)index {
    if (index < self.buttonArray.count) {
        MOTIndexTypeButton *button = self.buttonArray[index];
        button.isTap = NO;
        button.selected = NO;
    }
}

#pragma mark -私有方法
//单选时的操作
- (void)radioTouchedFunctionWithButton:(MOTIndexTypeButton*) sender {
    sender.selected = YES;
    for (MOTIndexTypeButton *button in self.buttonArray) {
        if (![button isEqual:sender]) {
            if (button.enabled) {
                if (!button.isCheck) {
                    button.selected = NO;
                }
            }
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(didSelectedByRadioTypeWithIndex:)]) {
        [self.delegate didSelectedByRadioTypeWithIndex:sender.index];
    }
}


#pragma mark -点击事件
- (void)clickFunction:(MOTIndexTypeButton*) sender {
    
    if (sender.isTap) {
        sender.selected = NO;
        
        if ([self.delegate respondsToSelector:@selector(didTappedWithIndex:)]) {
            [self.delegate didTappedWithIndex:sender.index];
        }
        
        return;
    }
    
    if (sender.isCheck) {
        sender.selected = !sender.selected;
        
        if ([self.delegate respondsToSelector:@selector(didSeleted:Index:)]) {
            [self.delegate didSeleted:sender.selected Index:sender.index];
        }
        
        return;
    }
    else {
        [self radioTouchedFunctionWithButton:sender];
    }
    
}

#pragma mark -通知方法

#pragma mark -销毁方法
- (void)dealloc {
//    MOTLog(@"%@销毁了", self.class);
}


@end
