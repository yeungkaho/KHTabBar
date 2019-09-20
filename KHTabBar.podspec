Pod::Spec.new do |spec|
  spec.name         = 'KHTabBar'
  spec.platform 	= :ios, '10.0'
  spec.version      = '1.0.0'
  spec.homepage     = 'https://github.com/yeungkaho/KHTabBar'
  spec.authors      = { 'Kaho Yeung' => 'ykh.dev@gmail.com' }
  spec.summary      = 'A custom tab bar for iOS that supports image sequence animations.'
  spec.source       = { :git => 'https://github.com/yeungkaho/KHTabBar.git', :tag => '1.0.0'}

  spec.requires_arc = true

  spec.source_files = 'KHTabBar/KHTabBar/*.swift'
  spec.static_framework = true

end
