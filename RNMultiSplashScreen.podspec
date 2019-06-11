require 'json'
package = JSON.parse(File.read('package.json'))

Pod::Spec.new do |s|
  s.name                = "RNMultiSplashScreen"
  s.version             = package["version"]
  s.summary             = package["description"]
  s.license             = package['license']
  s.author              = "Ryan Leckey"

  s.homepage            = "https://github.com/Haz111/react-native-multi-splash-screen"
  s.source              = { :git => "https://github.com/Haz111/react-native-multi-splash-screen.git", :tag => "v#{s.version}" }

  s.platform            = :ios, "8.0"
  s.preserve_paths      = 'README.md', 'package.json', '*.js'
  s.source_files        = 'ios/RNMultiSplashScreen/**/*.{h,m}'
  s.public_header_files = ['ios/RNMultiSplashScreen/RNMultiSplashScreen.h']

  s.dependency "React"
end
