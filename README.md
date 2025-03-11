# OpenKYC SDK Integration & Usage Guide (iOS)

[Android Guide](./docs/README.md)。

# 1. Introduction

OpenKYC offers essential features for identity verification and card management. It enables businesses to perform identity verification through document checks, facial recognition, and selfie authentication. Users can also apply for cards, track application status, and manage their card information. The platform supports KYC compliance and fraud prevention, ensuring secure and reliable processes.

# 2. SDK Integration

## 2.1 Install Dependencies

CocoaPods Installation

To install OpenKYC SDK via CocoaPods, add the following line to your Podfile:
```
   pod 'OpenKYC', '~> 1.0.0'
```
Then, run the following command in the terminal to install the SDK:
```
   pod install
```
Manually Installation

Download the [OpenKYC](https://github.com/decard-tech/open-kyc-ios/releases/download/1.0.0/OpenKYC-1.0.0.zip)
## 2.2 Setup Scheme
<img width="666" alt="截屏2025-02-21 13 23 20" src="https://github.com/user-attachments/assets/9e6696f8-69a4-4a91-aefd-d5b716c6aa35" />

In your Info.plist file:

    <key>CFBundleURLTypes</key>
    <array>
        <dict>
            <key>CFBundleTypeRole</key>
            <string>Editor</string>
            <key>CFBundleURLSchemes</key>
            <array>
                <string>openkyc</string>
            </array>
        </dict>
    </array>

## 2.3 Initialize the SDK

In your AppDelegate.swift, initialize the OpenKYC SDK by calling the configure method with your API key:
```
import OpenKYC

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
    OpenKYCManager.shared.getUserAgent { userAgent in
            guard let ua = userAgent else { return }
            let userAgentString = ua + "company" + "version"
            OpenKYCManager.shared.setUserAgent(userAgentString)
        }
    return true
}
```
# 3. Using the SDK

## 3.1 Start the Identity Verification Process

To start the identity verification process, create an OpenKYCController
```
let controller = OpenKYCController(url: url, delegate: self)
controller.modalPresentationStyle = .fullScreen
present(controller, animated: true, completion: nil)
```
## 3.2 OpenKYCWebViewControllerDelegate

This protocol defines the methods that allow the implementing class to respond to events triggered by the OpenKYCWebViewController, which is typically used to display web-based content or processes related to identity verification within the OpenKYC SDK. These delegate methods are called when specific actions or events occur in the web view controller.

##### 1.openKYCWebViewController(_:didReceiveMessage:)
- **Description**: This method is called when the OpenKYCWebViewController receives a message from the web content (JavaScript or other embedded content).
- **Parameters**:
    - controller: The instance of OpenKYCWebViewController that sent the message.
    - message: A String containing the message received from the web view.
- **Use Case**: This method allows you to handle and process messages sent from the web content inside the web view, which could be used for various interactions, such as notifying the app of a user action or an event occurring within the web content.
  
##### 2.openKYCWebViewController(_:didReceiveDeepLink:)
   - **Description**: This method is called when the OpenKYCWebViewController receives a deep link (a URL) from the web content.
   - **Parameters**:
      - controller: The instance of OpenKYCWebViewController that received the deep link.
      - deepLink: A URL containing the deep link.
   - **Use Case**: Deep links are often used to navigate users to specific parts of the app. This method can be used to handle URLs that need to open a specific screen or trigger an action within the app, allowing for seamless navigation from the web content to native app screens.
     
##### 3.openKYCWebViewController(_:didReceiveMessage:name:payload:)
   - **Description**: This method is a more detailed version of the didReceiveMessage method, allowing the web view to send messages with additional context.
   - **Parameters**:
    - controller: The instance of OpenKYCWebViewController that sent the message.
    - name: A String representing the name or type of the message.
    - payload: An optional dictionary ([String : Any]?) containing additional data related to the message. This can be any additional information sent from the web content (e.g., user details, status updates, etc.).
- **Use Case**: This method is ideal for handling structured messages with both a name and an associated payload. You can use the name to differentiate between different types of messages and the payload to access any associated data.
## 3.3 Handling Redirect URLs

If your application supports redirects (for example, in the case of OAuth), you will need to handle URL redirects in your AppDelegate.swift:
```
func application(_ app: UIApplication,
                 open url: URL,
                 options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    if OpenKYCManager.shared.handleRedirectScheme(url: url) {
        return true
    }
    return false
}
```
This method processes the URL after a redirect from an authentication provider, allowing the SDK to handle the response.

# 4. Frequently Asked Questions

Q1: How do I obtain the API url?
    •    You can obtain your API key by signing up and registering at the OpenKYC Developer Portal.

Q2: What should I do if the identity verification fails?
    •    Make sure the device’s camera and microphone are working properly and the necessary permissions have been granted. If the issue persists, retry the verification process.

