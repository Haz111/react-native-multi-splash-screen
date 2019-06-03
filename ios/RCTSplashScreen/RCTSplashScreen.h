#import <React/RCTBridgeModule.h>
#import <React/RCTRootView.h>

@interface RCTSplashScreen : NSObject <RCTBridgeModule>

+ (NSString *)splashImageNameForOrientation;
+ (void)initAndShow:(RCTRootView *)v rootViewController:(UIViewController *)rvc;
+ (void)hideSplashScreen;

@end
