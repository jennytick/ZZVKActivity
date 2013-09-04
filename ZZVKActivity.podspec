Pod::Spec.new do |s|
  s.name         = 'ZZVKActivity'
  s.version      = '0.0.1'
  s.license      =  {:type => 'MIT'} 
  s.homepage     = 'https://github.com/jennytick/ZZVKActivity'
  s.authors      =  {'Yevgeniya Zelenska' => 'yevgeniya.zel@gmail.com'} 
  s.summary      = 'ZZVKActivity provides ability to post text, URLs, images via VK after being added to actvity view controller.'
  s.source       =  {:git => 'https://github.com/jennytick/ZZVKActivity.git', :tag => s.version.to_s} 
  s.source_files = '*.{h,m}'
  s.platform     = :ios, '5.0'
  s.requires_arc = true
    
  s.dependency 'AFNetworking', '~> 1.3.1'
    s.prefix_header_contents = <<-EOS
    #import <Availability.h>
    
    #if __IPHONE_OS_VERSION_MIN_REQUIRED
    #import <SystemConfiguration/SystemConfiguration.h>
    #import <MobileCoreServices/MobileCoreServices.h>
    #import <Security/Security.h>
    #else
    #import <SystemConfiguration/SystemConfiguration.h>
    #import <CoreServices/CoreServices.h>
    #import <Security/Security.h>
    #endif
    EOS
end