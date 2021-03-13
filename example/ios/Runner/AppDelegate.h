#import <Flutter/Flutter.h>
#import <UIKit/UIKit.h>

@interface AppDelegate : FlutterAppDelegate
{
    FlutterMethodChannel* auviisChannel;
    int64_t active_channel_id;
}
@end
