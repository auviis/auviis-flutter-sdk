#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#include "AuviisSDKWrap.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;

    auviisChannel = [FlutterMethodChannel
                                              methodChannelWithName:@"com.auviis.sdk"
                                              binaryMessenger:controller.binaryMessenger];
    
    AuviisSDKWrap::getInstance()->setMethodChannel(auviisChannel);
    
    [auviisChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        if ([call.method  isEqual: @"Auviis_startSDK"]) {
            NSArray* args = (NSArray*) call.arguments;
            NSString * app_id = [args objectAtIndex: 0];
            NSString * app_signature = [args objectAtIndex: 1];
            AuviisSDKWrap::getInstance()->init([app_id UTF8String],[app_signature UTF8String]);
            AuviisSDKWrap::getInstance()->connect();
            result(0);
        }else if ([call.method  isEqual: @"Auviis_stopSDK"]) {
            AuviisSDKWrap::getInstance()->stop();
            result(0);
        }
        else if ([call.method  isEqual: @"Auviis_speakerOut"]) {
            AuviisSDKWrap::getInstance()->outputToSpeaker();
            result(0);
        }
        else if ([call.method  isEqual: @"Auviis_micOut"]) {
            AuviisSDKWrap::getInstance()->outputToDefault();
            result(0);
        }
        else if ([call.method  isEqual: @"Auviis_unmuteSend"]) {
            AuviisSDKWrap::getInstance()->unmuteSend();
            result(0);
        }
        else if ([call.method  isEqual: @"Auviis_muteSend"]) {
            AuviisSDKWrap::getInstance()->muteSend();
            result(0);
        }
        else if ([call.method  isEqual: @"Auviis_joinChannel"]) {
            NSString * channel_id = call.arguments;
            AuviisSDKWrap::getInstance()->joinChannel([channel_id longLongValue]);
            result(0);
        }
        else if ([call.method  isEqual: @"Auviis_setActiveVoiceChannel"]) {
            NSString * channel_id = call.arguments;
            self->active_channel_id = [channel_id longLongValue];
            AuviisSDKWrap::getInstance()->setActiveVoiceChannel(self->active_channel_id);
            result(0);
        }
        else if ([call.method  isEqual: @"Auviis_sendVoiceChat"]) {
            AuviisSDKWrap::getInstance()->sendVoiceChat(self->active_channel_id);
            result(0);
        }
        else if ([call.method  isEqual: @"Auviis_recordVoice"]) {
            AuviisSDKWrap::getInstance()->recordVoice();
            result(0);
        }
        else if ([call.method  isEqual: @"Auviis_stopRecord"]) {
            AuviisSDKWrap::getInstance()->stopRecord();
            result(0);
        }else{
            result(FlutterMethodNotImplemented);
        }
    }];
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end

