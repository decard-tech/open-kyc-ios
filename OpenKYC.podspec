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
  spec.license      = { :type => 'MIT', :text => 'MIT' }
  spec.author       = { "Ryan" => "ryan.an@dcsserv.com" }
  
  spec.source       = { 
    :git => "https://github.com/decard-tech/open-kyc-ios.git", 
    :tag => "#{spec.version}" 
  }

  spec.vendored_frameworks = "OpenKYC.xcframework"
  spec.platform = :ios, "14.0"
  spec.swift_version = "5.5"
end
