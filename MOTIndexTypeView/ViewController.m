//
//  ViewController.m
//  MOTIndexTypeView
//
//  Created by orztech on 17/7/14.
//  Copyright © 2017年 orztech. All rights reserved.
//

#import "ViewController.h"
#import "MOTIndexTypeView.h"

@interface ViewController () <MOTIndexTypeViewDelegate>
@property (weak, nonatomic) IBOutlet MOTIndexTypeView *indexView;
@property (weak, nonatomic) IBOutlet UILabel *radioLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkLabel;
@property (weak, nonatomic) IBOutlet UILabel *tapLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.indexView.delegate = self;

    self.indexView.imageNameArray = @[@"1", @"2", @"3"];
    self.indexView.selectedImageNameArray = @[@"11", @"22", @"33"];
    self.indexView.highlightedImageNameArray = @[@"11", @"22", @"33"];
    self.indexView.disabledImageNameArray = @[@"111", @"222", @"333"];
}

- (IBAction)top:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    self.indexView.topLine = sender.selected;
}
- (IBAction)bottom:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    self.indexView.bottomLine = sender.selected;
}
- (IBAction)left:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    self.indexView.leftLine = sender.selected;
}
- (IBAction)right:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    self.indexView.rightLine = sender.selected;
}
- (IBAction)randomColor:(id)sender {
    UIColor *color = [UIColor colorWithHue:arc4random() % 255 / 255.0 saturation:arc4random() % 255 / 255.0 brightness:arc4random() % 255 / 255.0 alpha:1.0];
    
    self.indexView.lineColor = color;
}
- (IBAction)typeClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    self.indexView.isCheck = sender.selected;
}
- (IBAction)oneChekType:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        [self.indexView setCheckTypeWithIndex:0];
    }
    else {
        [self.indexView setRadioTypeWithIndex:0];
    }
}
- (IBAction)twoCheckType:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        [self.indexView setCheckTypeWithIndex:1];
    }
    else {
        [self.indexView setRadioTypeWithIndex:1];
    }
}
- (IBAction)threeCheckType:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        [self.indexView setCheckTypeWithIndex:2];
    }
    else {
        [self.indexView setRadioTypeWithIndex:2];
    }
}
- (IBAction)oneTapType:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        [self.indexView setTapTypeWithIndex:0];
    }
    else {
        [self.indexView cancelTapTypeWithIndex:0];
    }
}
- (IBAction)twoTapType:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        [self.indexView setTapTypeWithIndex:1];
    }
    else {
        [self.indexView cancelTapTypeWithIndex:1];
    }
}
- (IBAction)threeTapType:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        [self.indexView setTapTypeWithIndex:2];
    }
    else {
        [self.indexView cancelTapTypeWithIndex:2];
    }
}
- (IBAction)allSelected:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    [self.indexView setAllButtonWithSelected:sender.selected];
}
- (IBAction)allEnabled:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    [self.indexView setAllButtonWithEnabled:!sender.selected];
}
- (IBAction)oneSelected:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    [self.indexView setOneButtonWithSelected:sender.selected Index:0];
}
- (IBAction)twoSelected:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    [self.indexView setOneButtonWithSelected:sender.selected Index:1];
}
- (IBAction)threeSelected:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    [self.indexView setOneButtonWithSelected:sender.selected Index:2];
}
- (IBAction)oneEnabled:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    [self.indexView setOneButtonWithEnabled:!sender.selected Index:0];
}
- (IBAction)twoEnabled:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    [self.indexView setOneButtonWithEnabled:!sender.selected Index:1];
}
- (IBAction)threeEnabled:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    [self.indexView setOneButtonWithEnabled:!sender.selected Index:2];
}

#pragma mark -代理
- (void)didSeleted:(BOOL)selected Index:(NSInteger)index {
    self.checkLabel.text = [NSString stringWithFormat:@"第%ld个按钮的状态为 %d ", (long)index, selected];
    
    self.checkLabel.backgroundColor = [UIColor lightGrayColor];
    self.tapLabel.backgroundColor = [UIColor whiteColor];
    self.radioLabel.backgroundColor = [UIColor whiteColor];
}
- (void)didTappedWithIndex:(NSInteger)index {
    self.tapLabel.text = [NSString stringWithFormat:@"点击了第%ld个按钮", (long)index];
    
    self.checkLabel.backgroundColor = [UIColor whiteColor];
    self.tapLabel.backgroundColor = [UIColor lightGrayColor];
    self.radioLabel.backgroundColor = [UIColor whiteColor];
}
- (void)didSelectedByRadioTypeWithIndex:(NSInteger)index {
    self.radioLabel.text = [NSString stringWithFormat:@"单选模式 选择了第%ld个按钮", (long)index];
    
    self.checkLabel.backgroundColor = [UIColor whiteColor];
    self.tapLabel.backgroundColor = [UIColor whiteColor];
    self.radioLabel.backgroundColor = [UIColor lightGrayColor];
}



@end
