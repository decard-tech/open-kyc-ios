source 'https://cdn.cocoapods.org/'
source 'https://github.com/Artsy/Specs.git'

platform :ios, '14.0'
inhibit_all_warnings!

target 'open-kyc-ios-demo' do
  pod 'OpenKYC', '~> 1.1.0'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    puts target.name
  end
end
