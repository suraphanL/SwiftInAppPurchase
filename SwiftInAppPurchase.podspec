#
# Be sure to run `pod lib lint SwiftInAppPurchase.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SwiftInAppPurchase"
  s.version          = "1.0.0"
  s.summary          = "A swift wrapper for iOS in app purchases."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
This CocoaPod provide the ability of in app purchase (IAP)
                       DESC

  s.homepage         = "https://github.com/rpzzzzzz/IAPMaster"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'Apache'
  s.author           = { "Rawd" => "suraphan.d@gmail.com" }
  s.source           = { :git => "https://github.com/rpzzzzzz/IAPMaster.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/Rawd7'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'SwiftInAppPurchase' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'StoreKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
