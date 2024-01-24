static NSString *Flavor = @"mocha";
static NSString *Accent = @"blue";

static BOOL YouTube = NO;
static BOOL Reddit = NO;

// From RUITheme:
@interface RUITheme : NSObject
- (UIColor *)overlayColor;
- (UIColor *)bodyTextColor;
- (UIColor *)bodyTextColorHalf;
- (UIColor *)metaTextColor;
- (UIColor *)linkTextColor;
- (UIColor *)buttonTextColor;
- (UIColor *)buttonHighlightTextColor;
- (UIColor *)lightTextColor;
- (UIColor *)darkTextColor;
- (UIColor *)flairBackgroundColor;
- (UIColor *)navBarColor;
- (UIColor *)navIconColor;
- (UIColor *)navIconColorHalf;
- (UIColor *)loadingPlaceHolderColor;
- (UIColor *)bodyColor;
- (UIColor *)listBackgroundColor;
- (UIColor *)canvasColor;
- (UIColor *)modalBackgroundColor;
- (UIColor *)lineColor;
- (UIColor *)fieldColor;
- (UIColor *)actionColor;
- (UIColor *)buttonColor;
- (UIColor *)joinButtonColor;
- (UIColor *)activeColor;
- (UIColor *)inactiveColor;
- (UIColor *)flairTextColor;
- (UIColor *)highlightColor;
- (UIColor *)cellHighlightColor;
- (UIColor *)logoColor;
- (UIColor *)callToActionBackgroundColor;
- (UIColor *)warningColor;
- (UIColor *)nsfwColor;
- (UIColor *)originalContentColor;
- (UIColor *)orangeRedColor;
- (UIColor *)orangeColor;
- (UIColor *)mangoColor;
- (UIColor *)limeColor;
- (UIColor *)greenColor;
- (UIColor *)mintColor;
- (UIColor *)blueColor;
- (UIColor *)alienBlueColor;
- (UIColor *)periwinkleColor;
- (UIColor *)goldColor;
- (UIColor *)offWhiteColor;
- (UIColor *)semiBlackColor;
- (UIColor *)hostedVideoBackgroundColor;
- (UIColor *)approvedColor;
- (UIColor *)deletedColor;
- (UIColor *)gildedColor;
- (UIColor *)chatBubbleBorderColor;
- (UIColor *)lineColorForDepth0;
- (UIColor *)lineColorForDepth1;
- (UIColor *)lineColorForDepth2;
- (UIColor *)lineColorForDepth3;
- (UIColor *)lineColorForDepth4;

- (instancetype)init;
@end

@interface _UIVisualEffectFilterEntry : NSObject {
    NSString *_filterType;
}

@property(nonatomic, copy) NSString *filterType;
@end

@interface _UIVisualEffectSubview : UIView
@end
@interface _UIVisualEffectBackdropView : _UIVisualEffectSubview
@end
