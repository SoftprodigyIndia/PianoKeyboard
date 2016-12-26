# Uncomment this line to define a global platform for your project
 platform :ios, '10.0'

target 'PianoKeyBoard' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

#pod 'Alamofire', '~> 4.0.1'
    pod 'AlamofireImage', '~> 3.1'
  # Pods for PianoKeyBoard

  target 'PianoKeyBoardTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'PianoKeyBoardUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
