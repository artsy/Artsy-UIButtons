#import <UIKit/UIKit.h>

@interface ARCircularActionButton : UIButton
+ (CGFloat)buttonSize;
- (instancetype)initWithImageName:(NSString *)imageName;
@end

@interface ARButton : UIButton
@property (nonatomic, readwrite) BOOL shouldDimWhenDisabled;
@property (nonatomic, readwrite) BOOL shouldAnimateStateChange;
- (void)setup;
- (void)setEnabled:(BOOL)enabled animated:(BOOL)animated;
@end

@interface ARUnderlineButton : ARButton
- (void)setUnderlinedTitle:(NSString *)title underlineRange:(NSRange)range forState:(UIControlState)state;
@end

@interface ARInquireButton : ARUnderlineButton
@end

@interface ARSentenceCaseButton : ARButton
@end

@interface ARNavigationTabButton : ARSentenceCaseButton
@end

// ARFlatButton is effectively an abstract class. It provides no colors for text, background or border.
// The only time you might want to instantiate and customize a one-off ARFlatButton is when none of
// the generic subclasses is suitable.

@interface ARFlatButton : ARSentenceCaseButton
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state animated:(BOOL)animated;

- (void)setBorderColor:(UIColor *)borderColor forState:(UIControlState)state;
- (void)setBorderColor:(UIColor *)borderColor forState:(UIControlState)state animated:(BOOL)animated;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated;
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated;
@end

@interface ARMenuButton : ARFlatButton
@end

@interface ARClearFlatButton : ARFlatButton
@end

@interface ARWhiteFlatButton : ARFlatButton
@end

@interface ARBlackFlatButton : ARFlatButton
@end
