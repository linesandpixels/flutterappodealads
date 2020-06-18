#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutterappodealads.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutterappodealads'
  s.version          = '0.0.1'
  s.summary          = 'Appodeal Plugin for Flutter.'
  s.description      = <<-DESC
Appodeal Plugin for Flutter.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  #Appodeal Pods
  s.static_framework = true
  #s.dependency 'APDAdColonyAdapter', '2.6.4.1'
  #s.dependency 'APDAmazonAdsAdapter', '2.6.4.1' 
  s.dependency 'APDAppLovinAdapter', '2.6.4.1' 
  s.dependency 'APDAppodealAdExchangeAdapter', '2.6.4.1' 
  #s.dependency 'APDChartboostAdapter', '2.6.4.1' 
  s.dependency 'APDFacebookAudienceAdapter', '2.6.4.1' 
  s.dependency 'APDGoogleAdMobAdapter', '2.6.4.1' 
  #s.dependency 'APDInMobiAdapter', '2.6.4.1' 
  #s.dependency 'APDInnerActiveAdapter', '2.6.4.1' 
  #s.dependency 'APDIronSourceAdapter', '2.6.4.1' 
  #s.dependency 'APDMintegralAdapter', '2.6.4.1' 
  #s.dependency 'APDMyTargetAdapter', '2.6.4.1' 
  #s.dependency 'APDOguryAdapter', '2.6.4.1' 
  #s.dependency 'APDOpenXAdapter', '2.6.4.1' 
  #s.dependency 'APDPubnativeAdapter', '2.6.4.1' 
  #s.dependency 'APDSmaatoAdapter', '2.6.4.1' 
  #s.dependency 'APDStartAppAdapter', '2.6.4.1' 
  #s.dependency 'APDTapjoyAdapter', '2.6.4.1' 
  #s.dependency 'APDUnityAdapter', '2.6.4.1' 
  #s.dependency 'APDVungleAdapter', '2.6.4.1' 
  #s.dependency 'APDYandexAdapter', '2.6.4.1'

  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'
end
