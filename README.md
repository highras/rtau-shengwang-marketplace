# 使用云上曲率实时音视频审核插件

本文介绍如何在你的项目中集成和使用云上曲率实时音视频审核插件（以下简称实时音视频审核插件），包括Android和iOS平台。

## 技术原理

实时音视频审核插件是对云上曲率[实时音频审核](https://docs.ilivedata.com/audiocheck/product/_information/)和[实时视频审核](https://docs.ilivedata.com/videocheck/product/_information/)核心 API 的封装。通过调用[声网视频 SDK v4.0.0 Beta](https://docs.agora.io/cn/video-call-4.x-beta/product_video_ng?platform=Android) 的 [setExtensionProperty](https://docs.agora.io/cn/video-call-4.x-beta/API%20Reference/java_ng/API/class_irtcengine.html#api_setextensionproperty) 或 [setExtensionPropertyWithVendor](https://docs.agora.io/cn/video-call-4.x-beta/API%20Reference/ios_ng/API/class_irtcengine.html#api_setextensionproperty)方法，传入指定的 `key` 和 `value` 参数，你可以快速集成云上曲率的实时语音识别和翻译的能力。支持的 key 和 value 详见[插件的 key-value 列表]（）。

## 前提条件

- Android 开发环境需满足以下要求：
  - Android Studio 4.1 以上版本。
  - 运行 Android 5.0 或以上版本的真机（非模拟器）。
- iOS 开发环境需满足以下要求：
  - Xcode 9.0 或以上版本。
  - 运行 iOS 11.0 或以上版本的真机（非模拟器）。

## 准备工作

### 使用声网 SDK 实现视频通话

实时音视频审核插件需要与[声网视频 SDK v4.0.0 Beta](https://docs.agora.io/cn/video-call-4.x-beta/product_video_ng?platform=Android) 搭配使用。参考以下文档集成视频 SDK v4.0.0 Beta 并实现基础的视频通话：
- [实现视频通话（Android）](https://docs.agora.io/cn/video-call-4.x-beta/start_call_android_ng?platform=Android#%E5%BB%BA%E7%AB%8B%E9%A1%B9%E7%9B%AE)
- [实现视频通话（iOS）](https://docs.agora.io/cn/video-call-4.x-beta/start_call_ios_ng%20?platform=iOS#%E5%88%9B%E5%BB%BA%E9%A1%B9%E7%9B%AE)

### 购买和激活插件

在声网控制台[购买和激活](https://docs.agora.io/cn/extension_customer/get_extension?platform=All%20Platforms)实时音视频审核插件，保存好获取到的 `appKey` 和 `appSecret`，后续初始化插件时需要用到。

### 集成插件

参考如下步骤在你的项目中集成实时音视频审核插件：

**Android**


1. 在[声网云市场下载](https://docs.agora.io/cn/extension_customer/downloads?platform=All%20Platforms)页面下载实时音视频审核插件的 `Android` 插件包。解压后，将所有 `libagora-iLiveData-filter.aar` 文件保存到项目文件夹的  `/app/libs`  路径。

2. 打开 `app/build.gradle` 文件，在 `dependencies` 中添加如下行：
   ```java
   implementation fileTree(dir: "libs", include: ["*.jar", "*.aar"])
   ```

**iOS**


1. 在[声网云市场下载](https://docs.agora.io/cn/extension_customer/downloads?platform=All%20Platforms)页面下载实时音视频审核插件的 iOS 插件包。解压后，将所有 `.framework` 库文件保存到你的项目文件夹下。
3. 在 Xcode 中[添加动态库](https://help.apple.com/xcode/mac/current/#/dev51a648b07)，确保 **Embed** 属性设置为 **Embed & Sign**。

以如下项目结构为例，你可以把库文件保存到 `<ProjectName>` 路径下。

```shell
├── <ProjectName>
├── <ProjectName>.xcodeproj
```

## 调用流程

本节介绍插件相关接口的调用流程。接口的参数解释详见[接口说明](云上曲率实时音视频审核插件接口说明.md)。

### 1. 启用插件

**Android**
初始化声网 `AgoraRtcEngine` 时，调用 `enableExtension` 启用插件。

```java
    RtcEngineConfig config = new RtcEngineConfig();
    config.addExtension("agora-iLiveData-filter-pre");
    engine = RtcEngine.create(config);
    engine.enableExtension("iLiveDataPre", "RTAU_PRE", true);
```

**iOS**
初始化声网 `AgoraRtcEngineKit` 时，调用 `enableExtensionWithVendor` 启用插件。


```objective-c
   // 启用RTAU插件
   [_agoraKit enableExtensionWithVendor:[iLiveDataSimpleFilterManager companyName]
                              extension:[iLiveDataSimpleFilterManager rtau_plugName]
                                enabled:YES]；
```

### 2. 使用插件

**Android**
调用`setExtensionProperty` 指定key 为 `startAudit` 在value中以json格式传入`appkey` `appsecret`等参数。

```java
    JSONObject jsonObject = new JSONObject();
    jsonObject.put("appKey", 123456);
    jsonObject.put("appSecret", "xxxxxx");
    jsonObject.put("streamId", "123456");
    jsonObject.put("audioLang", "zh-CN");
    jsonObject.put("callbackUrl", "");
```


```java
    engine.setExtensionProperty("iLiveDataPre", "RTAU_PRE ", "startAudit_pre", jsonObject.toString());
```



**iOS**
调用`setExtensionPropertyWithVendor`指定 key 为 `startAudit` 在value中以json格式传入`appkey` `appsecret`等参数。

```objective-c
     NSDictionary * auditDic = @{
                                @"appKey":@"appKey",
                                @"appSecret":@"appSecret",
                                @"streamId":@"streamId",
                                @"audioLang":@"zh-CN",
                                @"callbackUrl":@"callbackUrl"
                               };
                                   
     NSData * auditDicJsonData = [NSJSONSerialization dataWithJSONObject:auditDic options:NSJSONWritingPrettyPrinted error:nil];
     NSString * auditDicJsonString = [[NSString alloc] initWithData:auditDicJsonData encoding:NSUTF8StringEncoding];
     
     [_agoraKit setExtensionPropertyWithVendor:[iLiveDataSimpleFilterManager companyName]
                                     extension:[iLiveDataSimpleFilterManager rtau_plugName])
                                           key:@"startAudit"
                                         value:auditDicJsonString];
```




### 3. 结束使用插件

**Android**
调用 `setExtensionProperty`方法并指定 key 为 `closeAudit` 来结束实时音视频审核插件的使用。

```java
    engine.setExtensionProperty("iLiveDataPre", "RTAU_PRE", "closeAudit_pre", "{}");
```

**iOS**
调用 `setExtensionPropertyWithVendor`方法并指定 key 为 `closeAudit` 来结束实时音视频审核插件的使用。

```objective-c
    [self.kit setExtensionPropertyWithVendor:[iLiveDataSimpleFilterManager companyName]
                                   extension:[iLiveDataSimpleFilterManager rtau_plugName]
                                         key:"closeAudit"
                                       value:""];
```



## 示例项目

| 平台    | 语言        | 示例项目                                                     |
| :------ | :---------- | :----------------------------------------------------------- |
| Android | Java        | [项目示例](https://github.com/highras/rtau-agora-marketplace) |
| iOS     | Objective-C | [项目示例](https://github.com/highras/rtau-agora-marketplace) |

### 运行步骤

**Android**

1. 克隆仓库：
  ```shell
	git clone (https://github.com/highras/rtvt-agora-marketplace)
  ```
2. 将项目的\app\src\main\res\values\string_configs.xml 文件中的"agora_app_id" 和"agora_access_token"替换成你自己声网的appid和apptoken 获取 App ID 请参考[开始使用 Agora 平台](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms); 将"livedata_audit_pid" 和 "livedata_audit_key"替换成云上曲率项目id和key  获取方式详见[购买和激活插件](https://docs.agora.io/cn/extension_customer/get_extension?platform=All%20Platforms)。将"livedata_callbackUrl" 填入审核结果地址
3. 连接一台 Android 真机（非模拟器），运行项目。 输入频道号  点击“加入频道” 加入成功后 点击"开始审核"  回调的url地址可以看到审核结果

**iOS**

1. 从[声网云市场下载](https://docs.agora.io/cn/extension_customer/downloads?platform=All%20Platforms)页面下载实时音视频审核插件的 iOS 插件包并解压。
2. 在 Xcode 中打开项目。
3. 打开 `ViewController`，进行如下修改：
	- 将 agora_appId 替换为你的 App ID。获取 App ID 请参考[开始使用 Agora 平台](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms)。
	- 将 appKey 和 appSecret 分别替换为你的 `appKey` 和 `appSecret`。获取方式详见[购买和激活插件](https://docs.agora.io/cn/extension_customer/get_extension?platform=All%20Platforms)。 将"callbackUrl"替换成你的审核结果地址

  ```objective-c
  NSString *const appID = @"<YOUR_APP_ID>";
  NSString *const appkey = @"<YOUR_APP_KEY>";
  NSString *const secret = @"<YOUR_SECRET>";
  ```
4. 连接一台 iOS 真机（非模拟器），运行项目。


### 预期效果

运行成功后，示例项目会安装到你的 Android 或 iOS 设备上。

1. 启动 app，你可以在界面上看到 `add room` 和 `Start RTAU` 按钮
2. 点击 `add room` 进入房间。
3. 点击 `Start RTAU` 开始实时音视频审核。
4. 点击 `End Audit` 结束实时音视频审核。

## 接口说明

插件所有相关接口的参数解释详见（[接口说明](云上曲率实时音视频审核插件接口说明.md)）。

