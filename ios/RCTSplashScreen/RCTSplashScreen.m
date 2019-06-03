#import "RCTSplashScreen.h"

static RCTRootView *rootView = nil;
static UIViewController *rootViewController = nil;

@implementation RCTSplashScreen

RCT_EXPORT_MODULE(RNMultiSplashScreen)

+ (NSString *)splashImageNameForOrientation {
    NSLog(@"RNMultiSplashScreen splashImageNameForOrientation"); 
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

+ (void)initAndShow:(RCTRootView *)v rootViewController:(UIViewController *)rvc{
    NSLog(@"RNMultiSplashScreen initAndShow"); 

    rootView = v;
    rootViewController = rvc;

    rootView.loadingViewFadeDelay = 0.1;
    rootView.loadingViewFadeDuration = 0.1;
    UIImageView *view = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    NSString* launchFn = [RCTSplashScreen splashImageNameForOrientation];
    view.image = [UIImage imageNamed:launchFn];

    [[NSNotificationCenter defaultCenter] removeObserver:rootView  name:RCTContentDidAppearNotification object:rootView];

    [rootView setLoadingView:view];
    rootView.loadingView.hidden = NO;
}

RCT_EXPORT_METHOD(hideSplashScreen) {
    NSLog(@"RNMultiSplashScreen hideSplashScreen 1"); 
    if (!rootView) {
        return;
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(rootView.loadingViewFadeDuration * NSEC_PER_SEC)),
                   dispatch_get_main_queue(),
                   ^{
                       NSLog(@"RNMultiSplashScreen hideSplashScreen 2"); 
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
    NSLog(@"RNMultiSplashScreen showNativeView. name: %@", name); 

    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"RNMultiSplashScreen showNativeView"); 
        UIView *v = [[[NSBundle mainBundle] loadNibNamed:name owner:self options:nil] firstObject];
        UIViewController * vc = [[UIViewController alloc] init];
        vc.view = v;

        [rootViewController presentViewController:vc animated:NO completion:nil];
    });
}

RCT_EXPORT_METHOD(showNativeViewWithText:(NSString *)name text:(NSString *)text) {
    NSLog(@"RNMultiSplashScreen showNativeView. name: %@ text: %@", name, text); 

    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"RNMultiSplashScreen showNativeViewWithText"); 
        UIView *v = [[[NSBundle mainBundle] loadNibNamed:name owner:self options:nil] firstObject];

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 20)];

        [label setTextColor:[UIColor blackColor]];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setFont:[UIFont fontWithName: @"Trebuchet MS" size: 14.0f]]; 
        label.text = text;
        [v addSubview:label];

        UIViewController * vc = [[UIViewController alloc] init];
        vc.view = v;

        [rootViewController presentViewController:vc animated:NO completion:nil];

    });
}

RCT_EXPORT_METHOD(backToReact) {
    NSLog(@"RNMultiSplashScreen backToReact"); 
   [self hideSplashScreen];
}

@end
