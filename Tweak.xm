#import <CoreFoundation/CoreFoundation.h>
#import <Foundation/Foundation.h>
#import <Foundation/NSUserDefaults+Private.h>
#import <UIKit/UIColor.h>
#import <UIKit/UIKit.h>
#import <Tweak.h>
#import <rootless.h>

#include "vendor/YouTubeHeader/YTCommonColorPalette.h"

#include "ColorHelper.h"

%group SystemGroup
%hook UIColor
+ (UIColor *)labelColor { return colors[TEXT]; }

+ (UIColor *)systemBackgroundColor { return colors[BASE]; }
+ (UIColor *)secondarySystemBackgroundColor { return colors[BASE]; }
+ (UIColor *)systemFillColor { return colors[BASE]; }
+ (UIColor *)systemGroupedBackgroundColor { return colors[BASE]; }
+ (UIColor *)groupTableViewBackgroundColor { return colors[BASE]; }
+ (UIColor *)tableCellPlainBackgroundColor { return colors[BASE]; }

+ (UIColor *)tableCellGroupedBackgroundColor { return colors[MANTLE]; }
+ (UIColor *)tertiarySystemFillColor { return colors[MANTLE]; }
+ (UIColor *)secondarySystemGroupedBackgroundColor { return colors[MANTLE]; }

+ (UIColor *)tertiarySystemBackgroundColor { return colors[CRUST]; }

+ (UIColor *)systemBlueColor { return colors[ACCENT]; }
+ (UIColor *)linkColor { return colors[ACCENT]; }

+ (UIColor *)systemGray4Color { return colors[SURFACE0]; }
+ (UIColor *)systemGray5Color { return colors[SURFACE0]; }
+ (UIColor *)tertiaryLabelColor { return colors[SURFACE0]; }
+ (UIColor *)opaqueSeparatorColor { return colors[SURFACE0]; }

+ (UIColor *)secondaryLabelColor { return colors[SUBTEXT0]; }

+ (UIColor *)placeholderTextColor { return colors[SUBTEXT1]; }

+ (UIColor *)systemGreenColor { return colors[GREEN]; }

+ (UIColor *)systemRedColor { return colors[RED]; }

+ (UIColor *)systemYellowColor { return colors[YELLOW]; }
%end

%hook _UIStatusBar
- (void)setForegroundColor:(UIColor *)arg0 { %orig(colors[TEXT]); }
%end

@interface _UIKBCompatInputView
@property (nonatomic, copy, readwrite) UIColor *backgroundColor;
@end

%hook _UIKBCompatInputView
- (void)didMoveToWindow { %orig; self.backgroundColor = colors[BASE]; }
%end
%end

%group YouTubeGroup
%hook YTCommonColorPalette
- (UIColor *)background1 { return colors[BASE]; }
- (UIColor *)background2 { return colors[MANTLE]; }
- (UIColor *)background3 { return colors[CRUST]; }

- (UIColor *)brandBackgroundSolid { return colors[MANTLE]; }
- (UIColor *)brandBackgroundPrimary { return colors[MANTLE]; }
- (UIColor *)brandBackgroundSecondary { return colors[CRUST]; }


- (UIColor *)generalBackgroundA { return colors[BASE]; }
- (UIColor *)generalBackgroundB { return colors[MANTLE]; }
- (UIColor *)generalBackgroundC { return colors[CRUST]; }

- (UIColor *)textPrimary { return colors[TEXT]; }
- (UIColor *)textSecondary { return colors[SUBTEXT0]; }
- (UIColor *)textDisabled { return colors[OVERLAY0]; }

- (UIColor *)overlayTextPrimary { return colors[TEXT]; }
- (UIColor *)overlayTextSecondary { return colors[SUBTEXT0]; }
- (UIColor *)overlayTextTertiary { return colors[OVERLAY2]; }

- (UIColor *)brandLinkText { return colors[TEXT]; }

- (UIColor *)outline { return colors[OVERLAY2]; }

- (UIColor *)baseBackground { return colors[BASE]; }

- (UIColor *)staticBrandWhite { return colors[TEXT]; }
%end
%end

%group RedditGroup
%hook RUITheme
- (UIColor *)bodyColor { return colors[BASE]; }
- (UIColor *)bodyTextColor { return colors[TEXT]; }

- (UIColor *)lightTextColor { return colors[TEXT]; }
- (UIColor *)darkTextColor { return colors[BASE]; }
%end
%end

static void loadPreferences() {
    BOOL isSystem = [NSHomeDirectory() isEqualToString:@"/var/mobile"];

    NSDictionary *preferences = nil;

    if (isSystem) {
        CFArrayRef keyList = CFPreferencesCopyKeyList((CFSTR("com.catppuccin.ios.preferences")), kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
        if (keyList) {
            preferences = CFBridgingRelease(CFPreferencesCopyMultiple(keyList, CFSTR("com.catppuccin.ios.preferences"), kCFPreferencesCurrentUser, kCFPreferencesAnyHost));
            if (!preferences) preferences = [NSDictionary new];
            CFRelease(keyList);
        }
    }

    if (!preferences) preferences = [NSDictionary dictionaryWithContentsOfFile:ROOT_PATH_NS(@"/var/mobile/Library/Preferences/com.catppuccin.ios.preferences.plist")];

    if (preferences) {
        Flavor = [preferences objectForKey:@"flavor"];
        Accent = [preferences objectForKey:@"accent"];
        YouTube = [[preferences objectForKey:@"youtube"] boolValue];
        Reddit = [[preferences objectForKey:@"reddit"] boolValue];
    }

    [ColorHelper updateColors];
}

%ctor {
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPreferences, CFSTR("com.catppuccin.ios.preferences/reload"), NULL, CFNotificationSuspensionBehaviorCoalesce);
    loadPreferences();

    %init(SystemGroup);
    if (YouTube) { %init(YouTubeGroup); }
    if (Reddit) { %init(RedditGroup); }
}
