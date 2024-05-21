//
//  ViewController.m
//  AgoraRtcKitTest
//
//  Created by zsl on 2022/8/31.
//

#import "ViewController.h"
#import "ViewController+UI.h"

@interface ViewController ()<AgoraRtcEngineDelegate,AgoraRtcEngineDelegate2,AgoraMediaFilterEventDelegate>

@property(nonatomic,strong)AgoraRtcEngineKit * kit;
@property(nonatomic,strong)AgoraRtcEngineConfig * config;
@property(nonatomic,strong)NSString * agoraToken;

@property(nonatomic,strong)NSString * agora_appId;
@property(nonatomic,strong)NSString * agora_Token;
@property(nonatomic,strong)NSString * agora_RoomId;


@property(nonatomic,strong)NSString * appKeyRTAU;
@property(nonatomic,strong)NSString * appSecretRTAU;
@property(nonatomic,strong)NSString * callbackUrl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //audit
    self.appKeyRTAU = @"";
    self.appSecretRTAU = @"";
    self.callbackUrl = @"";//Callback address for receiving audit results
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        self.agora_appId = @"";
        self.agora_RoomId = @"";
        
        
        [self setUpUI];
        self.agoraToken = self.agora_Token;
        self.config = [[AgoraRtcEngineConfig alloc] init];
        self.config.appId = self.agora_appId;
        self.config.areaCode = AgoraAreaCodeTypeGlobal;
        self.config.channelProfile = AgoraChannelProfileLiveBroadcasting;
        self.config.audioScenario = AgoraAudioScenarioDefault;
        self.config.eventDelegate = self;

        self.kit = [AgoraRtcEngineKit sharedEngineWithConfig:self.config delegate:self];
        
        
        //audio
        NSLog(@"[self.kit setClientRole:AgoraClientRoleBroadcaster]  %d",[self.kit setClientRole:AgoraClientRoleBroadcaster]);
        NSLog(@"[self.kit enableAudio];  %d",[self.kit enableAudio]);
        NSLog(@"self.kit enableExtensionWithVendor:  %d",[self.kit enableExtensionWithVendor:[iLiveDataSimpleFilterManager_pre companyName] extension:[iLiveDataSimpleFilterManager_pre rtvt_pre_plugName] enabled:YES]);
        NSLog(@"[self.kit setAudioProfile:AgoraAudioProfileDefault]  %d",[self.kit setAudioProfile:AgoraAudioProfileDefault]);
        NSLog(@"[self.kit setDefaultAudioRouteToSpeakerphone:YES];   %d",[self.kit setDefaultAudioRouteToSpeakerphone:YES]);
        
        
        //video
        AgoraVideoEncoderConfiguration * videoEncoderConfiguration = [[AgoraVideoEncoderConfiguration alloc] initWithSize:CGSizeMake(120, 160)
                                                                                                                frameRate:AgoraVideoFrameRateFps15
                                                                                                                  bitrate:AgoraVideoBitrateStandard
                                                                                                          orientationMode:AgoraVideoOutputOrientationModeFixedPortrait
                                                                                                               mirrorMode:AgoraVideoMirrorModeAuto];
        [self.kit setVideoEncoderConfiguration:videoEncoderConfiguration];
        NSLog(@"[self.kit enableVideo];  %d",[self.kit enableVideo]);
        NSLog(@"self.kit enableExtensionWithVendor:  %d",[self.kit enableExtensionWithVendor:[iLiveDataSimpleFilterManager_pre companyName] extension:[iLiveDataSimpleFilterManager_pre rtau_pre_plugName] enabled:YES]);
        
        AgoraRtcVideoCanvas * videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
        videoCanvas.uid = 0;
        // the view to be binded

        UIView * myView = [[UIView alloc] initWithFrame:CGRectMake(30, 60, 120, 160)];
        myView.backgroundColor = [UIColor orangeColor];
        [self.view addSubview:myView];
        videoCanvas.view = myView;
        videoCanvas.renderMode = AgoraVideoRenderModeHidden;
        [self.kit setupLocalVideo:videoCanvas];
        [self.kit startPreview];
        
    });
    
}
-(void)_startRtauButtonClick{
    
    int64_t ts1 = [[NSDate date] timeIntervalSince1970] * 1000;
    NSDictionary * audioCheckDic = @{@"appKey":self.appKeyRTAU,
                                     @"appSecret":self.appSecretRTAU,
                                     @"streamId":[NSString stringWithFormat:@"%lld",ts1],
                                     @"audioLang":@"zh-CN",
                                     @"callbackUrl" : self.callbackUrl,
                                     
    };

    
    NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:audioCheckDic options:NSJSONWritingPrettyPrinted error:nil];
    NSString * jsonStr2 = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
    
    
    BOOL start_check_result = [self _setProperty:@"startAudit_pre" value:jsonStr2 type:1];
    
    
    if (  start_check_result == 0 ) {
        
        NSLog(@"start success");
        [self.startRtauButton setTitle:@"End RTAU" forState:UIControlStateNormal];
        [self.startRtauButton addTarget:self action:@selector(_endRtauButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
        
        NSLog(@"start fail");
        
    }
}
-(void)_endRtauButtonClick{
    
    BOOL end_check_result = [self _setProperty:@"closeAudit_pre" value:@"end" type:1];
    if (end_check_result == 0) {
        [self.startRtauButton setTitle:@"Start RTAU" forState:UIControlStateNormal];
        [self.startRtauButton addTarget:self action:@selector(_startRtauButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
}
-(void)_startAddRoomButtonClick{
    
    int result = [self.kit joinChannelByToken:self.agoraToken channelId:self.agora_RoomId info:nil uid:0 joinSuccess:^(NSString * _Nonnull channel, NSUInteger uid, NSInteger elapsed) {
        
        
    }];
    if (result == 0) {
        
        [self.addRoomButton setTitle:@"add room is ok" forState:UIControlStateNormal];
        [self.addRoomButton removeTarget:self action:@selector(_startAddRoomButtonClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
}

//0 rtvt 1rtau
-(BOOL)_setProperty:(NSString*)key value:(NSString*)value type:(int)type{
    
    return [self.kit setExtensionPropertyWithVendor:[iLiveDataSimpleFilterManager_pre companyName]
                                          extension:[iLiveDataSimpleFilterManager_pre rtau_pre_plugName]
                                                key:key
                                              value:value];
    
    
}
-(void)onEvent:(NSString *)provider extension:(NSString *)extension key:(NSString *)key value:(NSString *)value{
    
    NSLog(@"onEvent  %@   %@  %@   %@",provider,extension,key,value);
    
    
    
}






#pragma mark ui

-(UIButton*)startRtauButton{
    if (_startRtauButton == nil) {
        _startRtauButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _startRtauButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_startRtauButton setTitle:@"Start RTAU" forState:UIControlStateNormal];
        [_startRtauButton addTarget:self action:@selector(_startRtauButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _startRtauButton.backgroundColor = YS_Color_alpha(0x1b9fff,1);
        [_startRtauButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _startRtauButton;
}
-(UIButton*)addRoomButton{
    if (_addRoomButton == nil) {
        _addRoomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addRoomButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_addRoomButton setTitle:@"first add room" forState:UIControlStateNormal];
        [_addRoomButton addTarget:self action:@selector(_startAddRoomButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _addRoomButton.backgroundColor = YS_Color_alpha(0x1b9fff,1);
        [_addRoomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _addRoomButton;
}

@end
