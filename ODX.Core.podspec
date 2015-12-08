Pod::Spec.new do |s|
  s.name         = "ODX.Core"
  s.version      = "1.5.2"
  s.summary      = "Set of utility classes and methods for iOS & OSX apps."
  s.homepage     = "https://github.com/Rogaven/ODX.Core"
  s.license      = { :type => 'MIT', :file => 'LICENSE.txt' }
  s.author       = { "Alexey Nazaroff" => "alexx.nazaroff@gmail.com" }
  s.source       = { :git => "https://github.com/Rogaven/ODX.Core.git", :tag => s.version.to_s }
  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.6'
  s.watchos.deployment_target = '1.0'
  s.source_files = 'src/**/*'
  s.requires_arc = true
end
