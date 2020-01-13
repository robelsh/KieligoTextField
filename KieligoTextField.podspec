Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '11.0'
s.name = "KieligoTextField"
s.summary = "KieligoTextField is a custom textfield for Kieligo iOS App"
s.requires_arc = true

s.version = "0.1.0"

s.license = { :type => "MIT", :file => "LICENSE" }

s.author = { "Etienne Jézéquel" => "etienne.jezequel@gmail.com" }

s.homepage = "https://github.com/robelsh/KieligoTextField"

s.source = { :git => "https://github.com/robelsh/KieligoTextField.git",
             :tag => "#{s.version}" }

s.framework = "UIKit"
s.dependency 'RxSwift'
s.dependency 'RxCocoa'

s.source_files = "KieligoTextField/**/*.{swift}"

s.resources = "KieligoTextField/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"
s.resource_bundles = { 'KieligoTextField' => ['Pod/**/*.xib'] }

s.swift_version = "5"

end
