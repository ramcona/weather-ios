# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'TestCase' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for TestCase
  pod 'Alamofire'
  pod 'MaterialComponents/BottomSheet'
  pod 'Kingfisher'
  

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
      # some older pods don't support some architectures, anything over iOS 11 resolves that
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
      end
    end
  end

end
