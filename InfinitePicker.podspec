#
# Be sure to run `pod lib lint RxInfinitePicker.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'InfinitePicker'
  s.version          = '0.2.6'
  s.summary          = 'An iOS customized infinite picker.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
InfinitePicker is an customized infinite picker for iOS, it helps you to create a infinite picker using a customized cell.
                       DESC

  s.homepage         = 'https://github.com/lm2343635/InfinitePicker'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lm2343635' => 'lm2343635@126.com' }
  s.source           = { :git => 'https://github.com/lm2343635/InfinitePicker.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.dependency 'InfiniteLayout', '~> 0.2'

  s.default_subspec = 'Core'
  
  s.subspec 'Core' do |core|
    core.source_files = 'InfinitePicker/Classes/Core/**/*'
  end
  
  s.subspec 'Rx' do |rx|
    rx.dependency 'InfinitePicker/Core', '~> 0'
    rx.dependency 'RxCocoa', '~> 5'
    rx.dependency 'RxSwift', '~> 5'
    rx.source_files = 'InfinitePicker/Classes/Rx/**/*'
  end
end
