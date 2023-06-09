#
# Be sure to run `pod lib lint IGEX.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'IGEX'
  s.version          = '1.0.0'
  s.summary          = 'A short description of IGEX.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/95286760/IGEX'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '95286760' => 'syquandev@gmail.com' }
  s.source           = { :git => 'https://github.com/95286760/IGEX.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  
  s.ios.deployment_target = '11.0'
  s.swift_version = '5.0'
  
  s.source_files = 'IGEX/Classes/**/*.swift'
  
  s.resource_bundles = {
     'IGEXBundle' => [
     'IGEX/Assets/Storyboards/**/*.storyboard',
     'IGEX/Assets/Xibs/**/*.xib',
     'IGEX/Assets/Resources/**/*.xcassets',
     'IGEX/Assets/Localizable/*.lproj/*.strings',
     'IGEX/Classes/**/*.xib',
     'IGEX/Classes/**/*.storyboard']
  }
  
  s.static_framework = true
  
  s.dependency 'IGListKit'
  s.dependency 'RxSwift'
  s.dependency 'RxCocoa'
  s.dependency 'Core'
  s.dependency 'Shimmer', '1.0.2'
  
end
