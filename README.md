<!--# 使用云上曲率实时音视频审核插件
本文介绍如何在你的项目中集成和使用云上曲率实时音视频审核插件（以下简称实时音视频审核插件），包括Android和iOS平台。
-->
# 使用云上曲率实时音视频审核插件

本文介绍如何在你的项目中集成和使用云上曲率实时音视频审核插件（以下简称云上曲率审核插件），包括 Android 和 iOS 平台。

# LiveData RTAU
### [中文文档](README-zh.md) <br />
This guide is provided by LiveData. Agora is planning a documentation upgrade program for all extensions on the marketplace. Please stay tuned.

LiveData RTAU extension allows you to embed real-time video moderation into your mobile application providing automated AI recognition of various risky contents from backend,  without any upfront data training requirements.You can find the integration examples below.
云上曲率审核插件是对云上曲率[实时音频审核](https://docs.ilivedata.com/audiocheck/product/_information/)和[实时视频审核](https://docs.ilivedata.com/videocheck/product/_information/)核心 API 的封装。通过调用[声网视频 SDK v4.0.0](https://docs.agora.io/cn/video-call-4.x-beta/product_video_ng?platform=Android) 的 [setExtensionProperty](https://docs.agora.io/cn/video-call-4.x/API%20Reference/java_ng/API/toc_network.html#api_irtcengine_setextensionproperty) 或 [setExtensionPropertyWithVendor](https://docs.agora.io/cn/video-call-4.x/API%20Reference/ios_ng/API/toc_network.html#api_irtcengine_setextensionproperty)方法，传入指定的 `key` 和 `value` 参数，你可以快速集成云上曲率的实时音视频审核能力。


<!--## 技术原理

实时音视频审核插件是对云上曲率[实时音频审核](https://docs.ilivedata.com/audiocheck/product/_information/)和[实时视频审核](https://docs.ilivedata.com/videocheck/product/_information/)核心 API 的封装。通过调用[声网视频 SDK v4.2.0 Beta](https://docs.agora.io/cn/video-call-4.x-beta/product_video_ng?platform=Android) 的 [setExtensionProperty](https://docs.agora.io/cn/video-call-4.x-beta/API%20Reference/java_ng/API/class_irtcengine.html#api_setextensionproperty) 或 [setExtensionPropertyWithVendor](https://docs.agora.io/cn/video-call-4.x-beta/API%20Reference/ios_ng/API/class_irtcengine.html#api_setextensionproperty)方法，传入指定的 `key` 和 `value` 参数，你可以快速集成云上曲率的实时语音识别和翻译的能力。支持的 key 和 value 详见[插件的 key-value 列表]（）。
-->
## Understand the tech

The LiveData RTAU extension encapsulates the core APIs of the LiveData RTAU SDK. By calling the [setExtensionProperty](https://api-ref.agora.io/en/video-sdk/android/4.x/API/class_irtcengine.html#api_irtcengine_setextensionproperty) or [setExtensionPropertyWithVendor](https://api-ref.agora.io/en/video-sdk/ios/4.x/API/class_irtcengine.html#api_irtcengine_setextensionproperty) method of the [Agora Video SDK v4.x]() and passing in the corresponding `key` and `value`, you can quickly integrate capabilities of LiveData RTAU. For details, see the [key-value]() overview.

<!--## 前提条件

- Android 开发环境需满足以下要求：
  - Android Studio 4.1 以上版本。
  - 运行 Android 5.0 或以上版本的真机（非模拟器）。
- iOS 开发环境需满足以下要求：
  - Xcode 9.0 或以上版本。
  - 运行 iOS 9.0 或以上版本的真机（非模拟器）。
-->
## Prerequisites
The development environment has to meet the following requirements:
- Android
  - Android Studio 4.1 or later
  - A physical device (not an emulator) running Android 5.0 or later
- iOS
  - Xcode 9.0 or later.
  - A physical device (not an emulator) running iOS 9.0 or later.


<!--

## 准备工作

### 使用声网 SDK 实现视频通话

实时音视频审核插件需要与[声网视频 SDK v4.2.0 Beta](https://docs.agora.io/cn/video-call-4.x-beta/product_video_ng?platform=Android) 搭配使用。参考以下文档集成视频 SDK v4.2.0 Beta 并实现基础的视频通话：
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
-->

## Project Setup

The LiveData RTAU extension works together with the Video SDK v4.x. Refer to the following doc to integrate the SDK and start a basic voice call:

- SDK quickstart
  - [Android](https://docs.agora.io/en/voice-calling/get-started/get-started-sdk?platform=android)
  - [iOS](https://docs.agora.io/en/voice-calling/get-started/get-started-sdk?platform=ios)

To receive a `appKey` and a `appSecret` from LiveData
- please buy and activate the extension project on [Agora Console](https://console.agora.io/), then click View in the Secret column.
- or contact us via Agora.

## Integrate the extension
### Android

1. [Download]() the Android package of LiveData RTAu from the Extensions Marketplace.
2. Unzip the package, and save all `libagora-iLiveData-filter.aar` files to the `/app/libs` path of your project folder.
3. In the `app/build.gradle` file, add the following line in `dependencies`:

```java
implementation fileTree(dir: "libs", include: ["*.jar", "*.aar"])
```

### iOS

1. [Download]() the iOS package of LiveData RTAU from the Extensions Marketplace.
2. Unzip the package, and save all `.framework` files to the `<ProjectName> `path.
3. Ensure that you select **Embed & Sign** instead of **Embed**.

You can save `.framework` files under your project folder, as follows:

```shell
.
├── <ProjectName>
├── <ProjectName>.xcodeproj
```


<!--
## 调用流程

本节介绍插件相关接口的调用流程。接口的参数解释详见[接口说明](云上曲率实时音视频审核插件接口说明.md)。

### 1. 启用插件

**Android**
初始化声网 `AgoraRtcEngine` 时，调用 `enableExtension` 启用插件。

```java
    config.addExtension(iLiveData);
    engine = RtcEngine.create(config);
    engine.enableExtension("iLiveData", "RTAU", true);
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
    jsonObject.put("appKey", "appKey");
    jsonObject.put("appSecret", "appSecret");
    jsonObject.put("streamId", "streamId");
    jsonObject.put("audioLang", "zh-CN");
    jsonObject.put("callbackUrl", "");
```


```java
    engine.setExtensionProperty("iLiveData", "RTAU", "startAudit", jsonObject.toString());
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
    engine.setExtensionProperty("iLiveData", "RTAU", "closeAudit", "{}");
```

**iOS**
调用 `setExtensionPropertyWithVendor`方法并指定 key 为 `closeAudit` 来结束实时音视频审核插件的使用。

```objective-c
    [self.kit setExtensionPropertyWithVendor:[iLiveDataSimpleFilterManager companyName]
                                   extension:[iLiveDataSimpleFilterManager rtau_plugName]
                                         key:"closeAudit"
                                       value:"end"];
```
-->

## Call sequence
This section describes the call sequence you implement to use LiveData RTAU features in your app.

### 1. Enable the extension

#### Android
When you initialize `AgoraRtcEngine` :
- first call `addExtension` to load the extension
- then call `enableExtension` to enable the extension

```java
config.addExtension(iLiveData);
engine = RtcEngine.create(config);
engine.enableExtension("iLiveData", "RTAU", true);
```

#### iOS
When you initialize `AgoraRtcEngineKit`, call `enableExtensionWithVendor` to enable the extension.

```objective-c
// enable RTAU extension
[_agoraKit enableExtensionWithVendor:[iLiveDataSimpleFilterManager companyName]
                          extension:[iLiveDataSimpleFilterManager rtau_plugName]
                            enabled:YES]；
```

### 2. Start using the extension

#### Android

When you are ready to start using RTAU, call `setExtensionProperty` and pass in the corresponding keys and values:
- set key as`startAudit`
- set value as `appkey`, `appsecret`, `streamId`, `audioLang`, `callbackUrl` in JSON

```java
JSONObject jsonObject = new JSONObject();
jsonObject.put("appKey", "appKey");
jsonObject.put("appSecret", "appSecret");
jsonObject.put("streamId", "streamId");
jsonObject.put("audioLang", "zh-CN");
jsonObject.put("callbackUrl", "");
```

#### iOS

When you are ready to start using RTAU, call `setExtensionPropertyWithVendor` and pass in the corresponding keys and values:
- set key as`startAudit`
- set value as`appkey`, `appsecret`, `streamId`, `audioLang`, `callbackUrl` in JSON

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

### 3. Stop using the extension

#### Android

When stop using RTAU, call `setExtensionProperty` and pass in the corresponding keys and values:
- set key as`closeAudit`
- set value as `end`

```java
engine.setExtensionProperty("iLiveData", "RTAU", "closeAudit", "end");
```

#### iOS

When stop using RTAU, call `setExtensionPropertyWithVendor` and pass in the corresponding keys and values:
- set key as`closeAudit`
- set value as `end`

```objective-c
[self.kit setExtensionPropertyWithVendor:[iLiveDataSimpleFilterManager companyName]
                               extension:[iLiveDataSimpleFilterManager rtau_plugName]
                                     key:"closeAudit"
                                   value:"end"];
```

<!--## 示例项目

| 平台    | 语言        | 示例项目                                                     |
| :------ | :---------- | :----------------------------------------------------------- |
| Android | Java        | [项目示例](https://github.com/highras/rtau-agora-marketplace) |
| iOS     | Objective-C | [项目示例](https://github.com/highras/rtau-agora-marketplace) |

### 运行步骤

**Android**

1. 克隆仓库：
  ```shell
	git clone （//TODO: 仓库链接）
  ```
2. 从[声网云市场下载](https://docs.agora.io/cn/extension_customer/downloads?platform=All%20Platforms)页面下载实时音视频审核插件的 Android 插件包。解压后，将所有 `agora-iLiveData-filter.so` 文件保存到 `（TODO:具体路径） ` 。
3. 在 Android Studio 中打开示例项目 `（TODO: 工程文件的路径）`。
4. 将项目与 Gradle 文件同步。
5. 打开 `（TODO: 文件的具体路径）`，进行如下修改：
	- 将 `<YOUR_APP_ID>` 替换为你的 App ID。获取 App ID 请参考[开始使用 Agora 平台](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms)。
	- 将 `<YOUR_APP_KEY>` 和 `<YOUR_APP_SECRET>` 分别替换为你的 `appKey` 和 `appSecret`。获取方式详见[购买和激活插件](https://docs.agora.io/cn/extension_customer/get_extension?platform=All%20Platforms)。

  ```java
  // TODO: 替换成你的插件对应的代码
  public interface Config {
       String mAppId = "<YOUR_APP_ID>";
       String mAppKey = "<YOUR_APP_KEY>";
       String mAppSecret = "<YOUR_APP_SECRET>";
  }
  ```
4. 连接一台 Android 真机（非模拟器），运行项目。

**iOS**

1. 克隆仓库：
  ```shell
	git clone （//TODO: 仓库链接）
  ```
2. 从[声网云市场下载](https://docs.agora.io/cn/extension_customer/downloads?platform=All%20Platforms)页面下载实时音视频审核插件的 iOS 插件包。解压后，将所有 `.framwork` 库文件保存到 `（TODO: 具体路径）` 。
3. 在 Xcode 中打开项目 `（TODO: 工程文件的路径）`。
4. 打开 `（TODO: 文件的具体路径）`，进行如下修改：
	- 将 `<YOUR_APP_ID>` 替换为你的 App ID。获取 App ID 请参考[开始使用 Agora 平台](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms)。
	- 将 `<YOUR_APP_KEY>` 和 `<YOUR_APP_SECRET>` 分别替换为你的 `appKey` 和 `appSecret`。获取方式详见[购买和激活插件](https://docs.agora.io/cn/extension_customer/get_extension?platform=All%20Platforms)。

  ```objective-c
  // TODO: 替换成你的插件对应的代码
  NSString *const appID = @"<YOUR_APP_ID>";
  NSString *const appkey = @"<YOUR_APP_KEY>";
  NSString *const secret = @"<YOUR_SECRET>";
  ```
5. 连接一台 iOS 真机（非模拟器），运行项目。

```objective-c
// 启用 RTAU 插件
[_agoraKit enableExtensionWithVendor:[iLiveDataSimpleFilterManager companyName]
                          extension:[iLiveDataSimpleFilterManager rtau_plugName]
                            enabled:YES]；
```

### 2. 使用插件

1. 启动 app，你可以在界面上看到 `add room` 和 `Start RTAU` 按钮
2. 点击 `add room` 进入房间。
3. 点击 `Start RTAU` 开始实时音视频审核。
4. 点击 `End Audit` 结束实时音视频审核。
-->
## Sample Project

The complete sample code and project is provided on GitHub:
| Platform    | Language    | Sample Project   |
| :------ | :---------- | :--------------|
| Android | Java        | [Sample Project](https://github.com/highras/rtau-agora-marketplace) |
| iOS     | Objective-C | [Sample Project](https://github.com/highras/rtau-agora-marketplace) |

### Run the project

#### Android

1. git clone:
```shell
git clone https://github.com/highras/rtau-agora-marketplace.git
```
2. Open the Sample project in Android Studio.
3. Gradle sync with the project.
4. Open `app/src/main/res/values/string_configs.xml` file:
    - change `agora_app_id` and `agora_access_token` to your own Agora project information.
    - change `livedata_audit_pid` and `livedata_audit_key` to your own LiveData RTAU extension information。
    - change `livedata_callbackUrl` to your own destination URL to receive the moderation result from callback.
5. Using a physical Android device (not an emulator) to run the project.

#### iOS

1. git clone:
```shell
git clone https://github.com/highras/rtau-agora-marketplace.git
```
2. Open the project in Xcode. Access to the `iOS/SW_Test` path, and run the CocoaPods command as below:
```shell
pod install
```
3. Open the sample project `SW_Test.xcworkspace` in Xcode.
4. Open `iOS/SW_Test/SW_Test/ViewController.mm` file:
    - Fill in you own project information `appId`, `Token` and `RoomId` from Agora console.
    - Fill in your own LiveData RTAU extension information `appKeyRTAU` and `appSecretRTAU` from Agora console。
    - Fill in your own destination URL `callbackUrl` to receive the moderation result from callback。
5. Using a physical iOS device (not an emulator) to run the project.

### Result

After running the project successfully, LiveData RTAU sample project will be installed on you Android or iOS device.

1. Start the sample, fill in the channel number in the input box and click `Join`. The button `Join` will be change to `Leave` after join the channel successfully.
2. Click the button `start Audit`, you will see the real-time video on the screen shoot by the device camera.
3. Click the button `end Audit` to stop audit.

The result fo real-time video moderation can be checked through destination URL fiiled in the sample.
If you don't have backend to receive the moderation result, you can cheke from LiveData console. Please contact us via Agora to get the address.


<!--## 接口说明

插件所有相关接口的参数解释详见（[接口说明]()）。-->
## API reference
This section lists the APIs related to using extensions with the Agora SDK.

### Android

- [addExtension](https://api-ref.agora.io/en/video-sdk/android/4.x/API/rtc_api_data_type.html#api_irtcengine_addextension) in the `RtcEngineConfig` class
- [enableExtension](https://api-ref.agora.io/en/video-sdk/android/4.x/API/class_irtcengine.html#api_irtcengine_enableextension) in the `RtcEngine` class
- [setExtensionProperty](https://api-ref.agora.io/en/video-sdk/android/4.x/API/class_irtcengine.html#api_irtcengine_setextensionproperty) in the `RtcEngine` class
- [onEvent](https://api-ref.agora.io/en/video-sdk/android/4.x/API/class_imediaextensionobserver.html#callback_irtcengineeventhandler_onextensionevent) in the `IMediaExtensionObserver` class


### iOS

- [enableExtensionWithVendor](https://api-ref.agora.io/en/video-sdk/ios/4.x/API/class_irtcengine.html#api_irtcengine_enableextension) in the `AgoraRtcEngineKit` class
- [setExtensionPropertyWithVendor](https://api-ref.agora.io/en/video-sdk/ios/4.x/API/class_irtcengine.html#api_irtcengine_setextensionproperty) in the `AgoraRtcEngineKit` class
- [onEvent](https://api-ref.agora.io/en/video-sdk/ios/4.x/API/class_imediaextensionobserver.html#callback_irtcengineeventhandler_onextensionevent) in the `AgoraMediaFilterEventDelegate` class

### Key description
To implement the LiveData RTAU extension in app, you need to pass in the corresponding key-value pair。

#### `setExtensionProperty` or `setExtensionPropertyWithVendor`
When calling `setExtensionProperty` or `setExtensionPropertyWithVendor`, you can pass keys:

| Key    | Description  |
| ------ | ---------- |
| [startAudit]() | start real-time video moderation   |
| [closeAudit]()     | stop real-time video moderation |

#### `onEvent`
The Agora SDK `onEvent` contain error messages. For more details, please check [error code](https://docs.ilivedata.com/rtm/excursus/error-code/)

### Key-value description

#### startAudit
| Value    | Description  |
| ------ | ---------- |
| appKey | buy and activate the extension project on Agora Console, then click View in the Secret column   |
| appSecret    | buy and activate the extension project on Agora Console, then click View in the Secret column. |
| streamId   | real-time video streaming ID generated by the business  |
| audioLang   | language in real-time video streaming. It can be recognized automaticly by LiveData if pass null     |
| callbackUrl   | destination URL address.<br> The moderation result will be POST to the URL address using HTTP request.<br> By default, the moderation result will be callback only if various risky contents are recognized. <br> The moderation result value can be checked on [Image Moderation](https://docs.ilivedata.com/en/imagecheck/techdocs/respon/), [Audio Moderation](https://docs.ilivedata.com/en/audiocheck/callbackdoc/result-callback/).   |

#### closeAudit
| Value    | Description  |
| ------ | ---------- |
| end | optional parameter, stop real-time video moderation optional parameters |
