# MOTIndexTypeView
可进行不同模式选择的选择bar

## 效果图
![image](https://github.com/baoenzhao/MOTIndexTypeView/blob/master/test.gif)

## 适用场景
这个bar可以在某些界面中，第一个按钮需要开启/关闭的功能，第二个只需要点击，第三个按钮和第四个按钮是二选一，在这样的应用场景下就非常适合此控件，当然你也可以只用来单选控制，也可以多选控制，全看你的应用场景

## 使用方法
### 第一步 设置按钮的图片，只有在设置了图片之后才会创建按钮，按钮创建后不能进行修改（后期可以做成可修改）
```Object-C
self.indexView = [MOTIndexTypeView new];
self.indexView.imageNameArray = @[@"1", @"2", @"3"];
```
### 第二步 设置协议
```Object-C
self.indexView.delegate = self;
```
### 第三步 选择你需要的应用逻辑
```Object-C
self.indexView.isCheck = YES;
[self.indexView setTapTypeWithIndex:2];
[self.indexView setCheckTypeWithIndex:1];
[self.indexView setRadioTypeWithIndex:0];
```
