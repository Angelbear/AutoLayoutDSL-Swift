Pod::Spec.new do |s|
  s.name         = "AutoLayoutDSL-Swift"
  s.version      = "1.0.0"
  s.summary      = "A straightforward swift DSL/extension for more convinient auto layout management"
  s.homepage     = "https://github.com/Angelbear/AutoLayoutDSL-Swift"
  s.license      = "MIT"
  s.author       = { "Yangyang Zhao" => "yangyang.zhao.thu@gmail.com" }
  s.source       = { :git => "https://github.com/Angelbear/AutoLayoutDSL-Swift.git", :tag => "1.0.0" }
  s.source_files = 'Source/*.swift'
  s.requires_arc = true
  s.ios.deployment_target = '8.0'
end
