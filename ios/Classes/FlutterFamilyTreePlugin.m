#import "FlutterFamilyTreePlugin.h"
#if __has_include(<flutter_family_tree/flutter_family_tree-Swift.h>)
#import <flutter_family_tree/flutter_family_tree-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_family_tree-Swift.h"
#endif

@implementation FlutterFamilyTreePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterFamilyTreePlugin registerWithRegistrar:registrar];
}
@end
