Pod::Spec.new do |spec|
  spec.name         = "OpenKYC"
  spec.version      = "1.0.0"
  spec.summary      = "OpenKYC - KYC & Card Verification Framework for iOS"
  
  spec.description  = <<-DESC
  OpenKYC is a robust iOS framework designed to simplify KYC (Know Your Customer) and card information processing. 
  It provides seamless integration for identity verification and card detail recognition, 
  ensuring compliance with financial regulations during user onboarding or transactions.
                   DESC

  spec.homepage     = "https://github.com/decard-tech/open-kyc-ios"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Ryan" => "ryan.an@dcsserv.com" }
  
  # 1. 明确指定源码来源和 tag 匹配
  spec.source       = { 
    :git => "https://github.com/decard-tech/open-kyc-ios.git", 
    :tag => "#{spec.version}" 
  }
  
  # 2. 正确指定 XCFramework 路径（验证 ZIP 包结构）
  spec.vendored_frameworks = "OpenKYC.xcframework"
  
  # 3. 平台要求
  spec.platform = :ios, "14.0"
  
  # 4. 如需 Swift 版本支持（如果框架用 Swift 编写）
  spec.swift_version = "5.5"
  
  # 5. 依赖项声明（如果有第三方依赖）
  # spec.dependency "Alamofire", "~> 5.6"
  
  # 6. 确保文件层级正确
  # spec.source_files = "OpenKYC/**/*.{h,m,swift}"  # 可选，如果包含源代码
  # spec.resources = "OpenKYC/Resources/**/*"       # 可选，如果有资源文件
  
  # 7. 编译选项（如果需要）
  # spec.pod_target_xcconfig = {
  #   "EXCLUDED_ARCHS[sdk=iphonesimulator*]" => "arm64"  # 排除模拟器 arm64 架构（如需支持 M1）
  # }
end
