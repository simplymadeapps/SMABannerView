Pod::Spec.new do |s|

  s.name         = 'SMABannerView'
  s.version      = '1.0'
  s.summary      = 'An easy to use banner view with title and message for all your iOS projects.'

  s.homepage     = 'https://github.com/simplymadeapps/SMABannerView'
  s.license      = 'MIT'
  s.author       = { 'Bill Burgess' => 'bill@simplymadeapps.com' }

  s.ios.deployment_target = '8.0'
  s.tvos.deployment_target = '9.0'

  s.source       = { :git => 'https://github.com/simplymadeapps/SMABannerView.git', :tag => s.version }
  s.source_files  = 'SMABannerView/SMABannerView.swift'
  s.requires_arc = true

end
