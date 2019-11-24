#import "SimpleTorrentFlutterPlugin.h"
#import <simple_torrent_flutter/simple_torrent_flutter-Swift.h>

@implementation SimpleTorrentFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSimpleTorrentFlutterPlugin registerWithRegistrar:registrar];
}
@end
