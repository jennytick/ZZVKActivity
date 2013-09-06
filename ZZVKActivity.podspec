Pod::Spec.new do |s|
  s.name         = 'ZZVKActivity'
  s.version      = '0.0.4'
  s.license      =  {:type => 'MIT'} 
  s.homepage     = 'https://github.com/jennytick/ZZVKActivity'
  s.authors      =  {'Yevgeniya Zelenska' => 'yevgeniya.zel@gmail.com'} 
  s.summary      = 'ZZVKActivity provides ability to post text, URLs, images via VK after being added to actvity view controller.'
  s.source       =  {:git => 'https://github.com/jennytick/ZZVKActivity.git', :tag => s.version.to_s} 
  s.source_files = 'ZZVKActivity/*.{h,m}'
  s.platform     = :ios, '5.0'
  s.requires_arc = true
 
  s.resources = ["ZZVKActivity/*.png", "ZZVKActivity/*.xib"]
  
  s.dependency 'AFNetworking', '~> 1.3.1'
end