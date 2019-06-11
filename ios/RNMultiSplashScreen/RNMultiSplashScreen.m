#import "RNMultiSplashScreen.h"

static RCTRootView *rootView = nil;
static UIViewController *rootViewController = nil;
static UIFont *textFont = nil;
static UIColor *textColor = nil;

@implementation RNMultiSplashScreen

RCT_EXPORT_MODULE(RNMultiSplashScreen)

+ (void)initAndShow:(RCTRootView *)v rootViewController:(UIViewController *)rvc {
    rootView = v;
    rootViewController = rvc;
    textFont = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:16.0f];
    textColor = UIColor.blackColor;
    
    rootView.loadingViewFadeDelay = 0.1;
    rootView.loadingViewFadeDuration = 0.1;
    UIImageView *view = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    NSString* launchFn = [RNMultiSplashScreen splashImageNameForOrientation];
    view.image = [UIImage imageNamed:launchFn];
    
    [[NSNotificationCenter defaultCenter] removeObserver:rootView  name:RCTContentDidAppearNotification object:rootView];
    
    [rootView setLoadingView:view];
    rootView.loadingView.hidden = NO;
}

+ (void)setFont:(UIFont *)font {
    textFont = font;
}


+ (void)setColor:(UIColor *)color {
    textColor = color;
}

RCT_EXPORT_METHOD(hideNativeScreen) {
    if (!rootView) {
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(rootView.loadingViewFadeDuration * NSEC_PER_SEC)),
                   dispatch_get_main_queue(),
                   ^{
                       [UIView transitionWithView:rootView
                                         duration:rootView.loadingViewFadeDelay
                                          options:UIViewAnimationOptionTransitionCrossDissolve
                                       animations:^{
                                           rootView.loadingView.hidden = YES;
                                       }
                                       completion:^(__unused BOOL finished) {
                                           [rootView.loadingView removeFromSuperview];
                                       }];
                       
                       [rootViewController dismissViewControllerAnimated:NO completion:nil];
                   });
}

RCT_EXPORT_METHOD(showNativeView:(NSString *)name) {
    [self showNativeScreen:name text:nil];
}

RCT_EXPORT_METHOD(showNativeViewWithText:(NSString *)name text:(NSString *)text) {
    [self showNativeScreen:name text:text];
}

-(void)showNativeScreen:(NSString *)name text:(NSString *)text {
    dispatch_async(dispatch_get_main_queue(), ^{
        NativeViewController *nvc = [[NativeViewController alloc] initScreenController:rootViewController.view.bounds withBg:name text:text color:textColor font:textFont];
        [rootViewController presentViewController:nvc animated:NO completion:nil];
    });
}

+ (NSString *)splashImageNameForOrientation {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    CGSize viewSize = CGSizeMake(screenWidth, screenHeight);
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
    NSString* viewOrientation = @"Portrait";
    if (UIDeviceOrientationIsLandscape(orientation)) {
        viewSize = CGSizeMake(viewSize.height, viewSize.width);
        viewOrientation = @"Landscape";
    }
    
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    
    for (NSDictionary* dict in imagesDict) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
            return dict[@"UILaunchImageName"];
    }
    return nil;
}

@end
