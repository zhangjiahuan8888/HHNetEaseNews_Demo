//
//  NewsViewController.h
//  NetEaseNews
//
//  Created by 张家欢 on 16/7/21.
//  Copyright © 2016年 zhangjiahuan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, NewsType) {
    NewsTypeMain = 0,
    NewsTypeTiyu,
    NewsTypeYule,
    NewsTypeKeji,
    NewsTypeVideo,
    NewsTypeJingji,
    NewsTypeJunshi,
    NewsTypeWenhua,
    NewsTypeWeibo,
};
@interface NewsViewController : UIViewController

@property (nonatomic,assign) NewsType newsType;
@property (nonatomic,copy) NSString *newsStr;
@end
