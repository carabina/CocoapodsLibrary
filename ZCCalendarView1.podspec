Pod::Spec.new do |spec|
  spec.name         = "ZCCalendarView1"
  spec.version      = "1.0.0"
  spec.summary      = "ZCCalendarView UI Kit"
  spec.description  = "这是一个日历"
  spec.platform     = :ios, '7.0'
  spec.license      = { :type => 'Copyright', :text => 'Zac Inc. 2017' }
  spec.homepage     = 'https://github.com/zac-wang/CocoapodsLibrary.git'
  spec.author       = {'王志超' => 'love_iphone@qq.com'}
  spec.source       =  {:git => 'https://github.com/zac-wang/CocoapodsLibrary.git', :tag => spec.version.to_s }
  spec.source_files = 'Library/ZCCalendarView/**/*.{h,m,c,mm}'
  spec.public_header_files = 'Library/ZCCalendarView/**/*.{h}'
  spec.private_header_files = 'Library/ZCCalendarView/date/ZCCalendarDateLunarCalendar.h'
  spec.requires_arc = true
  spec.frameworks   = 'Foundation', 'UIKit'
  spec.ios.dependency 'ZCDate', :git => 'https://github.com/zac-wang/CocoapodsLibrary.git'
end