#import "FlutterappodealadsPlugin.h"
#if __has_include(<flutterappodealads/flutterappodealads-Swift.h>)
#import <flutterappodealads/flutterappodealads-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutterappodealads-Swift.h"
#endif

@implementation FlutterappodealadsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterappodealadsPlugin registerWithRegistrar:registrar];
}
@end
