# 使用云上曲率实时音视频审核插件

本文介绍如何在你的项目中集成和使用云上曲率实时音视频审核插件（以下简称云上曲率审核插件），包括 Android 和 iOS 平台。

## 技术原理

云上曲率审核插件是对云上曲率[实时音频审核](https://docs.ilivedata.com/audiocheck/product/_information/)和[实时视频审核](https://docs.ilivedata.com/videocheck/product/_information/)核心 API 的封装。通过调用[声网视频 SDK v4.0.0](https://docs.agora.io/cn/video-call-4.x-beta/product_video_ng?platform=Android) 的 [setExtensionProperty](https://docs.agora.io/cn/video-call-4.x/API%20Reference/java_ng/API/toc_network.html#api_irtcengine_setextensionproperty) 或 [setExtensionPropertyWithVendor](https://docs.agora.io/cn/video-call-4.x/API%20Reference/ios_ng/API/toc_network.html#api_irtcengine_setextensionproperty)方法，传入指定的 `key` 和 `value` 参数，你可以快速集成云上曲率的实时音视频审核能力。

## 前提条件

- Android 开发环境需满足以下要求：
  - Android Studio 4.1 以上版本。
  - 运行 Android 5.0 或以上版本的真机（非模拟器）。
- iOS 开发环境需满足以下要求：
  - Xcode 9.0 或以上版本。
  - 运行 iOS 9.0 或以上版本的真机（非模拟器）。

## 示例项目

| 平台    | 语言        | 示例项目                                                     |
| :------ | :---------- | :----------------------------------------------------------- |
| Android | Java        | [项目示例](https://github.com/highras/rtau-agora-marketplace) |
| iOS     | Objective-C | [项目示例](https://github.com/highras/rtau-agora-marketplace) |

### 运行步骤

**Android**

1. 克隆仓库：
  ```shell
	git clone https://github.com/highras/rtau-agora-marketplace.git
  ```
2. 在 Android Studio 中打开示例项目 `Android/RTVTRTAUFilter`。
3. 将项目与 Gradle 文件同步。
4. 打开 `app/src/main/res/values/string_configs.xml` 文件，进行如下修改：
  - 将 `"agora_app_id"` 和 `"agora_access_token"` 替换成你的声网 App ID 和 Token。获取方式请参考[开始使用 Agora 平台](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms)。
  - 将 `"livedata_audit_pid"` 和 `"livedata_audit_key"` 替换成你从声网控制台获取的 appKey 和 appSecret（分别对应云上曲率的项目 id 和 key）。获取方式详见[购买和激活插件](https://docs.agora.io/cn/extension_customer/get_extension?platform=All%20Platforms)。
  - 将 `"livedata_callbackUrl"` 替换成你的回调地址，用于接收审核结果。
5. 连接一台 Android 真机（非模拟器），运行项目。运行成功后，示例项目会安装到你的 Android 设备上。
6. 启动 app，在界面上输入你在生成声网 Token 时使用的频道名。
7. 点击**加入频道**按钮加入频道。
8. 加入成功后，点击**开始审核**按钮。如果有违规内容，你填入的回调地址会接收到审核结果。
9. 点击**结束审核**结束实时音视频审核。

**iOS**
1. 克隆仓库：
  ```shell
	git clone https://github.com/highras/rtau-agora-marketplace.git
  ```
2. 在 Xcode 中打开项目。
3. 在终端中进入 `iOS/SW_Test`，运行以下命令使用 CocoaPods 安装依赖：
  ```
	pod install
  ```
4. 在 Xcode 中打开项目 `SW_Test.xcworkspace`。
5. 打开 `iOS/SW_Test/SW_Test/ViewController.mm` 文件，进行如下修改：
	- 填入你的声网 App ID、Token 和频道名。获取方式请参考[开始使用 Agora 平台](https://docs.agora.io/cn/Agora%20Platform/get_appid_token?platform=All%20Platforms)。
	- 填入你的实时音视频审核 appKey 和 appSecret。获取方式详见[购买和激活插件](https://docs.agora.io/cn/extension_customer/get_extension?platform=All%20Platforms)。
	- 填入你的回调地址，用于接收审核结果。

  ```objective-c
  // 填入实时音视频审核 appKey
  self.appKeyRTAU = @"";
  // 填入实时音视频审核 appSecret
  self.appSecretRTAU = @"";
  // 填入接收审核结果的回调地址
  self.callbackUrl = @"";
  ```
  ```objective-c
  // 填入你的声网 App ID
  self.agora_appId = @"";
  // 填入你的声网频道名
  self.agora_RoomId = @"";
  // 填入你的声网 Token
  self.agora_Token = @"";
  ```
4. 连接一台 iOS 真机（非模拟器），运行项目。运行成功后，示例项目会安装到你的 iOS 设备上。
5. 启动 app，点击 **first add room** 按钮进入频道。
6. 点击 **Start RTAU** 开始实时音视频审核。如果有违规内容，你填入的回调地址会接收到审核结果。
7. 点击 **End RTAU** 按钮结束实时音视频审核。



## 集成和调用流程

### 准备工作

#### 使用声网 SDK 实现视频通话

云上曲率审核插件需要与[声网视频 SDK v4.0.0](https://docs.agora.io/cn/video-call-4.x/product_live_ng?platform=Android) 搭配使用。参考以下文档集成视频 SDK v4.0.0 并实现基础的视频通话：
- [实现视频通话（Android）](https://docs.agora.io/cn/video-call-4.x/start_call_android_ng?platform=Android#%E5%BB%BA%E7%AB%8B%E9%A1%B9%E7%9B%AE)
- [实现视频通话（iOS）](https://docs.agora.io/cn/video-call-4.x/start_call_ios_ng%20?platform=iOS#%E5%88%9B%E5%BB%BA%E9%A1%B9%E7%9B%AE)

> 该插件支持声网 SDK v4.2.0 或以上版本。

#### 购买和激活插件

在声网控制台[购买和激活](https://docs.agora.io/cn/extension_customer/get_extension?platform=All%20Platforms)云上曲率审核插件，保存好获取到的 `appKey` 和 `appSecret`，后续初始化插件时需要用到。

#### 集成插件

参考如下步骤在你的项目中集成云上曲率审核插件：

**Android**


1. 进入[声网控制台 > 云市场](https://console.agora.io/marketplace/list/all)页面，下载云上曲率实时音视频审核插件的 Android 插件包。解压后，将 `libagora-iLiveData-filter.aar` 文件保存到项目文件夹的  `/app/libs`  路径。

2. 打开 `app/build.gradle` 文件，在 `dependencies` 中添加如下行：
   ```java
   implementation fileTree(dir: "libs", include: ["*.jar", "*.aar"])
   ```

**iOS**


1. 进入[声网控制台 > 云市场](https://console.agora.io/marketplace/list/all)页面，下载云上曲率实时音视频审核插件的 iOS 插件包。解压后，将所有 `.framework` 库文件保存到你的项目文件夹下。
3. 在 Xcode 中[添加动态库](https://help.apple.com/xcode/mac/current/#/dev51a648b07)，确保 **Embed** 属性设置为 **Embed & Sign**。

以如下项目结构为例，你可以把库文件保存到 `<ProjectName>` 路径下。

```shell
├── <ProjectName>
├── <ProjectName>.xcodeproj
```

下面介绍插件相关接口的调用流程。接口的参数解释详见[接口说明](云上曲率实时音视频审核插件接口说明.md)。

### 1. 启用插件

**Android**

初始化声网 `RtcEngine` 时，调用 `addExtension` 加载插件，然后调用 `enableExtension` 启用插件。

```java
RtcEngineConfig config = new RtcEngineConfig();
config.addExtension("agora-iLiveData-filter");
engine = RtcEngine.create(config);
engine.enableExtension("iLiveData", "RTAU", true);
```

**iOS**

初始化声网 `AgoraRtcEngineKit` 时，调用 `enableExtensionWithVendor` 启用插件。


```objective-c
// 启用 RTAU 插件
[_agoraKit enableExtensionWithVendor:[iLiveDataSimpleFilterManager companyName]
                          extension:[iLiveDataSimpleFilterManager rtau_plugName]
                            enabled:YES]；
```

### 2. 使用插件

**Android**

调用`setExtensionProperty` 指定 key 为 `startAudit`，在 value 中以 JSON 格式传入`appkey`、`appsecret`等参数。

```java
JSONObject jsonObject = new JSONObject();
// 传入在声网控制台购买和激活插件后获取的 appKey
jsonObject.put("appKey", "appKey");
// 传入在声网控制台购买和激活插件后获取的 appSecret
jsonObject.put("appSecret", "appSecret");
// 传入音频流或视频流的 ID（需要你自行生成和维护）
jsonObject.put("streamId", "streamId");
// 传入音频流或视频流的语言（不传将自动识别）
jsonObject.put("audioLang", "zh-CN");
// 传入你的回调地址
jsonObject.put("callbackUrl", "");
```

```java
engine.setExtensionProperty("iLiveData", "RTAU", "startAudit", jsonObject.toString());
```


**iOS**

调用 `setExtensionPropertyWithVendor` 指定 key 为 `startAudit`，在 value 中以 JSON 格式传入 `appkey`、`appsecret`等参数。

```objective-c
NSDictionary * auditDic = @{
                          // 传入在声网控制台购买和激活插件后获取的 appKey
                          @"appKey":@"appKey",
                          // 传入在声网控制台购买和激活插件后获取的 appSecret
                          @"appSecret":@"appSecret",
                          // 传入音频流或视频流的 ID（需要你自行生成和维护）
                          @"streamId":@"streamId",
                          // 传入音频流或视频流的语言（不传将自动识别）
                          @"audioLang":@"zh-CN",
                          // 传入你的回调地址
                          @"callbackUrl":@"callbackUrl"
                          };

NSData * auditDicJsonData = [NSJSONSerialization dataWithJSONObject:auditDic options:NSJSONWritingPrettyPrinted error:nil];
NSString * auditDicJsonString = [[NSString alloc] initWithData:auditDicJsonData encoding:NSUTF8StringEncoding];

[_agoraKit setExtensionPropertyWithVendor:[iLiveDataSimpleFilterManager companyName]
                                extension:[iLiveDataSimpleFilterManager rtau_plugName])
                                      key:@"startAudit"
                                    value:auditDicJsonString];
```

### 3. 接收审核结果

审核结果会以 HTTP 请求的形式直接发送到你通过 `callbackUrl` 设置的地址。默认情况下，只有在检测到违规内容（包括音频和视频）时，才会回调审核结果。审核结果的回调参数解释参考[图片审核接口说明](https://docs.ilivedata.com/imagecheck/techdocs/respon/)、[音频审核接口说明](https://docs.ilivedata.com/audiocheck/callbackdoc/result-callback/)。

### 4. 结束使用插件

**Android**

调用 `setExtensionProperty` 方法并指定 key 为 `closeAudit` 来结束云上曲率审核插件的使用。

```java
engine.setExtensionProperty("iLiveData", "RTAU", "closeAudit", "{}");
```

**iOS**

调用 `setExtensionPropertyWithVendor` 方法并指定 key 为 `closeAudit` 来结束云上曲率审核插件的使用。

```objective-c
[self.kit setExtensionPropertyWithVendor:[iLiveDataSimpleFilterManager companyName]
                                extension:[iLiveDataSimpleFilterManager rtau_plugName]
                                      key:"closeAudit"
                                    value:""];
```


## 更多参考
### 接口说明

插件所有相关接口的参数解释详见[接口说明](云上曲率实时音视频审核插件接口说明.md)。
