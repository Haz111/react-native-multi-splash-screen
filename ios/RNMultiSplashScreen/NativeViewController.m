#import "RNMultiSplashScreen.h"

@implementation NativeViewController

- (instancetype)initScreenController:(CGRect)frame viewName:(NSString *)viewName text:(NSString *)text color:(UIColor *)color font:(UIFont *)font
{
    NativeViewController *nvc = [self init];
    UIView *view = [[[NSBundle mainBundle] loadNibNamed:viewName owner:self options:nil] objectAtIndex:0];
    view.frame = frame;
    
    if (text != nil && text != (id)[NSNull null] && text.length != 0 )
    {
        CGRect frameWithMargin = CGRectInset(frame, 32, 0);
        UILabel *label = [[UILabel alloc] initWithFrame:frameWithMargin];
        
        [label setTextColor:color];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:font];
        [label setNumberOfLines: 0];
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.text = text;
        [view addSubview:label];
        [label setCenter:view.center];
    }
    
    nvc.view = view;
    
    return nvc;
}
@end