# OpenKYC SDK Android 集成指南

## 0. 简介
OpenKYC SDK 是一个用于 Android/iOS 平台的开放式 KYC 验证工具包,提供了便捷的 WebView 集成方案。此文档为Android端集成指南。

## 1. 当前版本

```gradle
1.0.0
```

## 2. 系统要求

- Android API Level 23 (Android 6.0) 及以上
- AndroidX 支持
- Kotlin 项目支持

## 3. 集成步骤

### 3.1 添加Maven仓库

在项目根目录的 `settings.gradle` 或 `build.gradle` 中添加, 其中 `YOUR-USERNAME` 和 `YOUR-PASSWORD` 请联系Decard获取:
    
```gradle
repositories {
    maven {
        url "https://app-public-nexus.thedecard.com/repository/maven-releases/"
        credentials {
            username = "YOUR-USERNAME"
            password = "YOUR-PASSWORD"
        }
    }
}
```

### 3.2 添加依赖

在app模块或其他需要使用sdk的模块的 build.gradle 文件中添加:

```gradle
implementation 'com.dcs.decard:lib-openkyc:${version}'

// for example:
// implementation 'com.dcs.decard:lib-openkyc:1.0.0'
```

## 4. 基本用法

### 4.1 初始化并启动WebView （DSL风格，推荐）

```kotlin
val launcher = buildOpenKycLauncher {
    setUrl("https://your-kyc-url.com") // 通过 ‘/redirect/v1/guidance-link’ 接口获取的引导页链接
    setUserAgent("Your-User-Agent") // 自定义的webview的userAgent
    addHeader("Your-Header-Key", "Your-Header-Value") // 可选，添加加载页面时额外的请求头
    setCallback(object : OpenKycCallback {
        override fun onEvent(eventName: String, payload: Map<String, String>?) {
            // 处理回调事件
        }
    })
}

launcher.launch(context)
```

### 4.2 初始化并启动WebView （Builder模式）

```kotlin
// 使用 Builder 模式构建
val launcher = OpenKycLauncher.Builder()
    .setUrl("https://your-kyc-url.com")
    .setUserAgent("Your-User-Agent") 
    .addHeader("Your-Header-Key", "Your-Header-Value")
    .setCallback(object : OpenKycCallback {
        override fun onEvent(eventName: String, payload: Map<String, String>?) {
            // 处理回调事件
        }
    })
    .build()

// 启动 WebView
launcher.launch(context)
```

### 4.3 关闭WebView

```kotlin
launcher.finish()
```

## 5. 示例代码

```kotlin
class MainActivity : AppCompatActivity() {
    private var launcher: OpenKycLauncher? = null
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        launcher = buildOpenKycLauncher {
            setUrl("https://your-kyc-url.com")
            setUserAgent("Your-User-Agent")
            setCallback(object : OpenKycCallback {
                override fun onEvent(eventName: String, payload: Map<String, String>?) {
                    when(eventName) {
                        "DECARD_OPENAPI_CLOSE" -> launcher?.finish()
                        else -> Log.d("KYC", "Received event: $eventName")
                    }
                }
            })
        }
        
        launcher?.launch(this)
    }

    private const val CUSTOM_UA_SUFFIX = " YourApp/0.0.1 (Android 0.0.1)"

    fun getCustomUA(context: Context): String {
        val tempView = WebView(context)
        val res = tempView.settings.userAgentString + CUSTOM_UA_SUFFIX
        tempView.destroy()
        return res
    }
}
```


## 6. 技术支持

如有任何技术问题，请联系 DeCard 技术支持团队。
