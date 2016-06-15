Pod::Spec.new do |s|
  s.name         = 'ODX.Core'
  s.version      = '2.0.0'
  s.summary      = 'Set of utility classes and methods for iOS & OSX apps.'
  s.homepage     = 'https://github.com/Rogaven/ODX.Core'
  s.license      = { :type => 'MIT', :file => 'LICENSE.txt' }
  s.author       = { 'Alexey Nazaroff' => 'alexx.nazaroff@gmail.com' }
  s.source       = { :git => 'https://github.com/Rogaven/ODX.Core.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.6'
  s.watchos.deployment_target = '1.0'
  s.tvos.deployment_target = '9.0'

  s.requires_arc = true
  s.frameworks   = 'Foundation'

  s.source_files = 'src/**/*'
  s.public_header_files = 'src/**/*'
    
  #ODBlocks
  #ODHash
  
  #ODCompatibility
  #ODStringExt
  s.dependency 'ODDispatch'
  s.dependency 'ODLog'
  s.dependency 'ODPath'
  s.dependency 'ODProperties'
  s.dependency 'ODRuntime'
  s.dependency 'ODSerialization'
  s.dependency 'ODStringify'
  s.dependency 'ODTransformation'
  s.dependency 'ODValidation'
  s.dependency 'ODWeakify'
end