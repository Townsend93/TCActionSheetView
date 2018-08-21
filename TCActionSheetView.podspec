#
#  Be sure to run `pod spec lint TCActionSheetView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|


  s.name         = "TCActionSheetView"
  s.version      = "1.0.0"
  s.summary      = "仿微信action sheet."

  s.homepage     = "https://github.com/tanchenggithub/TCActionSheetView"

  s.license      = "MIT"

  s.author             = { "tanchenggithub" => "824376052@qq.com" }

    s.social_media_url   =  "https://github.com/tanchenggithub"

   s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/tanchenggithub/TCActionSheetView.git", :tag => s.version }

   s.requires_arc = true

 s.cource_files   =    "TCActionSheetView/TCActionSheetView/*.swift"



end
