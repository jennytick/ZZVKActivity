Pod::Spec.new do |s|
  s.name         = 'ZZVKActivity'
  s.version      = '0.0.1'
  s.license      =  :type => 'MIT' 
  s.homepage     = 'https://github.com/jennytick/ZZVKActivity'
  s.authors      =  'Yevgeniya Zelenska' => 'yevgeniya.zel@gmail.com' 
  s.summary      = 'ZZVKActivity provides ability to post text, URLs, images via VK after being added to actvity view controller.'
  s.source       =  :git => 'https://github.com/jennytick/ZZVKActivity.git', :tag => '0.0.1' 
  s.source_files = '*.{h,m}'
  s.requires_arc = true
end