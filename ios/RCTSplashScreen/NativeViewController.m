#import "RCTSplashScreen.h"

@implementation NativeViewController

- (instancetype)initScreenController:(CGRect)frame withBg:(NSString *)name text:(NSString *)text color:(UIColor *)color font:(UIFont *)font
{
    NativeViewController *nvc = [self init];
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    UIImage *image = [UIImage imageNamed:name];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = frame;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [view addSubview:imageView];
    
    if (text != nil && text != (id)[NSNull null] && text.length != 0 )
    {
        UILabel *label = [[UILabel alloc] initWithFrame:frame];
        
        [label setTextColor:color];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:font];
        label.text = text;
        [view addSubview:label];
        [label setCenter:view.center];
    }
    
    nvc.view = view;
    
    return nvc;
}
@end
