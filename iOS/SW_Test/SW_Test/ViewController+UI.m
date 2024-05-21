//
//  ViewController+UI.m
//  SW_Test
//
//  Created by zsl on 2022/9/2.
//

#import "ViewController+UI.h"

@implementation ViewController (UI)
-(void)setUpUI{
    
    [self.view addSubview:self.addRoomButton];
    [self.addRoomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(60);
        make.left.equalTo(self.view).offset(200);
        make.right.equalTo(self.view).offset(-100);
    }];
    
   
    [self.view addSubview:self.startRtauButton];
    [self.startRtauButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.addRoomButton);
        make.top.equalTo(self.addRoomButton.mas_bottom).offset(20);
    }];

}


@end
