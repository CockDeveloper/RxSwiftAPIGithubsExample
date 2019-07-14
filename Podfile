# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
inhibit_all_warnings!

def rx_swift
  pod 'RxSwift', '~> 5.0'
end

def rx_cocoa
  pod 'RxCocoa', '~> 5.0'
end

def common
  pod 'SwiftyBeaver', '~> 1.7.0'
  pod 'SwiftLint', '~> 0.33.0'
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
