# OpenKYC SDK Android Integration Guide

## 0. Introduction
OpenKYC SDK is an open KYC verification toolkit for Android/iOS platforms, providing convenient WebView integration solution. This document is the Android integration guide.

## 1. Current Version

```gradle
1.1.0
```

## 2. System Requirements

- Android API Level 23 (Android 6.0) and above
- AndroidX support
- Kotlin project support

## 3. Integration Steps

### 3.1 Add Maven Repository

Add to your project root's `settings.gradle` or `build.gradle`, where `YOUR-USERNAME` and `YOUR-PASSWORD` can be obtained from Decard:
    
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

### 3.2 Add Dependency

Add to build.gradle file of app module or other modules that need to use the SDK:

```gradle
implementation 'com.dcs.decard:lib-openkyc:${version}'

// for example:
// implementation 'com.dcs.decard:lib-openkyc:1.1.0'
```

## 4. Basic Usage

### 4.1 Initialize and Launch WebView (DSL Style, Recommended)

```kotlin
val launcher = buildOpenKycLauncher {
    setUrl("https://your-kyc-url.com") // Guidance page link obtained from '/redirect/v1/guidance-link' API
    setUserAgent("Your-User-Agent") // Custom WebView userAgent
    addHeader("Your-Header-Key", "Your-Header-Value") // Optional, add extra request headers when loading page
    setShowDecardLogo(true) // Optional, show DeCard logo in toolbar (default: true)
    setToolbarTitle("KYC Verification") // Optional, set custom toolbar title (if set, logo will be hidden)
    setCallback(object : OpenKycCallback {
        override fun onEvent(eventName: String, payload: Map<String, String>?) {
            // Handle callback events
            if (eventName == "DECARD_OPENAPI_CLOSE") {
                launcher?.finish()
            }
        }
    })
}

launcher.launch(context)
```

### 4.2 Initialize and Launch WebView (Builder Pattern)

```kotlin
// Build using Builder pattern
val launcher = OpenKycLauncher.Builder()
    .setUrl("https://your-kyc-url.com")
    .setUserAgent("Your-User-Agent") 
    .addHeader("Your-Header-Key", "Your-Header-Value")
    .setShowDecardLogo(true) // Optional, show DeCard logo in toolbar (default: true)
    .setToolbarTitle("KYC Verification") // Optional, set custom toolbar title (if set, logo will be hidden)
    .setCallback(object : OpenKycCallback {
        override fun onEvent(eventName: String, payload: Map<String, String>?) {
            // Handle callback events
            if (eventName == "DECARD_OPENAPI_CLOSE") {
                launcher?.finish()
            }
        }
    })
    .build()

// Launch WebView
launcher.launch(context)
```

### 4.3 Close WebView

```kotlin
launcher.finish()
```

## 5. API Reference

### 5.1 Configuration Methods

| Method | Required | Default | Description |
|--------|----------|---------|-------------|
| `setUrl(String)` | ✅ | - | Set the KYC guidance page URL |
| `setUserAgent(String)` | ✅ | - | Set custom WebView user agent |
| `addHeader(String, String)` | ❌ | - | Add extra HTTP headers |
| `setShowDecardLogo(Boolean)` | ❌ | `true` | Show/hide DeCard logo in toolbar |
| `setToolbarTitle(String)` | ❌ | `null` | Set custom toolbar title (overrides logo) |
| `setCallback(OpenKycCallback)` | ❌ | - | Set event callback handler |

### 5.2 Toolbar Customization

**Logo Display Rules:**
- When `setToolbarTitle()` is set: Custom title is shown, logo is hidden
- When `setToolbarTitle()` is not set and `setShowDecardLogo(true)`: DeCard logo is shown
- When `setToolbarTitle()` is not set and `setShowDecardLogo(false)`: Empty toolbar

## 6. Sample Code

```kotlin
class MainActivity : AppCompatActivity() {
    private var launcher: OpenKycLauncher? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        launcher = buildOpenKycLauncher {
            setUrl("https://your-kyc-url.com")
            setUserAgent("Your-User-Agent")
            setShowDecardLogo(false) // Hide DeCard logo
            setToolbarTitle("Identity Verification") // Set custom title
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

    // Your User Agent should look like this:
    // Mozilla/5.0 (Linux; Android 15; SM-S938N Build/AP3A.240905.015.A2; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/139.0.7258.143 Mobile Safari/537.36; appname/v2.64.1
}
```


## 7. Technical Support

For any technical issues, please contact DeCard technical support team.
