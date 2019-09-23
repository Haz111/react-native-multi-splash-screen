#import <React/RCTBridgeModule.h>
#import <React/RCTRootView.h>
#import <UIKit/UIKit.h>

@interface RNMultiSplashScreen : NSObject <RCTBridgeModule>
    
    + (void)initAndShow:(RCTRootView *)v rootViewController:(UIViewController *)rvc;
    + (void)hideSplashScreen;
    + (void)setFont:(UIFont *)font;
    + (void)setColor:(UIColor *)color;
    
@end

@interface NativeViewController : UIViewController
    
    - (instancetype)initScreenController:(CGRect)frame viewName:(NSString *)viewName text:(NSString *)text color:(UIColor *)color font:(UIFont *)font;
    
@end
