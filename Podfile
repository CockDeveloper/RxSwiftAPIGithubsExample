# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
inhibit_all_warnings!

def rx_swift
  pod 'RxSwift', '~> 5.0.0'
end

def rx_cocoa
  pod 'RxCocoa', '~> 5.0.0'
end

def common
  pod 'SwiftyBeaver', '~> 1.7.0'
  pod 'SwiftLint', '~> 0.33.1'
end

target 'RxSwiftAPIGithubsExample' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for RxSwiftAPIGithubsExample
  rx_swift
  rx_cocoa
  common

  target 'RxSwiftAPIGithubsExampleTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

target 'NetworkPlatform' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for NetworkPlatform
  rx_swift
  #rx_cocoa
  pod 'Alamofire', '~> 4.8.2'
  pod 'RxAlamofire', '~> 5.0.0'
  common

  target 'NetworkPlatformTests' do
    inherit! :search_paths
    # Pods for testing
    end
end
