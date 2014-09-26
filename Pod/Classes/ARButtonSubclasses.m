//
//  ARButtonSubclasses.m
//  Artsy
//
//  Created by Orta Therox on 18/11/2012.
//  Copyright (c) 2012 Artsy. All rights reserved.
//

#import "ARButtonSubclasses.h"
#import <Artsy+UIColors/UIColor+ArtsyColors.h>
#import "UIView+BooleanDependentAnimation.h"

#if __has_include(<Artsy+UIFonts/UIFont+ArtsyFonts.h>)
#import <Artsy+UIFonts/UIFont+ArtsyFonts.h>
#endif

#if __has_include(<Artsy+OSSUIFonts/UIFont+OSSArtsyFonts.h>)
#import <Artsy+OSSUIFonts/UIFont+OSSArtsyFonts.h>
#endif

@implementation ARButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) { return nil; }

    [self setup];

    return self;
}

- (void)awakeFromNib
{
    [self setup];
}

- (void)setEnabled:(BOOL)enabled
{
    [self setEnabled:enabled animated:YES];
}

- (void)setEnabled:(BOOL)enabled animated:(BOOL)animated
{
    [super setEnabled:enabled];
    CGFloat alpha = enabled ? 1 : 0.5;
    [UIView animateIf:animated withDuration:ARButtonAnimationDuration :^{
        self.alpha = alpha;
    }];
}

- (void)setup
{
    NSLog(@"ARButton shouldn't be used as it's an abstract class");
}

@end

@implementation ARUppercaseButton

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    title = [title uppercaseString];
    [super setTitle:title forState:state];
}

@end

@implementation ARMenuButton

- (CGSize)intrinsicContentSize
{
    return CGSizeMake(40, 40);
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat lineWidth = 1;

    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, lineWidth);

    CGContextAddEllipseInRect(context, rect);
    CGContextFillPath(context);

    CGRect borderRect = CGRectInset(rect, lineWidth * 0.5, lineWidth * 0.5);
    CGContextFillEllipseInRect (context, borderRect);
    CGContextStrokeEllipseInRect(context, borderRect);
    CGContextFillPath(context);
}

@end

@implementation ARModalMenuButton

- (void)setup
{
    self.titleLabel.font = [UIFont sansSerifFontWithSize:12];
}

@end

@interface ARFlatButton ()
@property (nonatomic, strong) NSMutableDictionary *backgroundColors;
@property (nonatomic, strong) NSMutableDictionary *borderColors;
@end

@implementation ARFlatButton

- (id)init
{
    return [self initWithFrame:CGRectZero];
}

- (void)setup
{
    self.backgroundColors = [NSMutableDictionary dictionary];
    self.borderColors = [NSMutableDictionary dictionary];

    self.titleLabel.font = [UIFont sansSerifFontWithSize:13];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;

    CALayer *layer = [self layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:0.0];
    [layer setBorderWidth:1.0];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
    [self setBackgroundColor:backgroundColor forState:state animated:YES];
}

- (void)setBorderColor:(UIColor *)borderColor forState:(UIControlState)state
{
    [self setBorderColor:borderColor forState:state animated:YES];

}

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state animated:(BOOL)animated
{
    [self.backgroundColors setObject:backgroundColor forKey:@(state)];
    if (state == self.state) {
        [self changeColorsForStateChangeAnimated:animated];
    }
}

- (void)setBorderColor:(UIColor *)borderColor forState:(UIControlState)state animated:(BOOL)animated
{
    [self.borderColors setObject:borderColor forKey:@(state)];
    if (state == self.state) {
        [self changeColorsForStateChangeAnimated:animated];
    }
}

- (void)changeColorsForStateChangeAnimated:(BOOL)animated
{
    if (!self.layer.backgroundColor) {
        self.layer.backgroundColor = [UIColor clearColor].CGColor;
    }

    UIColor *newBackgroundColor = [self.backgroundColors objectForKey:@(self.state)] ?: [self.borderColors objectForKey:UIControlStateNormal];
    if (newBackgroundColor && newBackgroundColor.CGColor != self.layer.backgroundColor) {
        if (animated) {
            CABasicAnimation *fade = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
            fade.fromValue = (__bridge id)(self.layer.backgroundColor);
            fade.toValue = (__bridge id)(newBackgroundColor.CGColor);
            fade.duration = ARButtonAnimationDuration;
            [self.layer addAnimation:fade forKey:@"backgroundFade"];
        }
        self.layer.backgroundColor = newBackgroundColor.CGColor;
    };

    if (self.layer.borderWidth < 1) { return; }

    if (!self.layer.borderColor) {
        self.layer.borderColor = [UIColor clearColor].CGColor;
    }

    UIColor *newBorderColor = [self.borderColors objectForKey:@(self.state)] ?: [self.borderColors objectForKey:UIControlStateNormal];
    if (newBorderColor && newBorderColor.CGColor != self.layer.borderColor) {
        if (animated) {
            CABasicAnimation *fade = [CABasicAnimation animationWithKeyPath:@"borderColor"];
            fade.fromValue = (__bridge id)(self.layer.borderColor);
            fade.toValue = (__bridge id)(newBorderColor.CGColor);
            fade.duration = ARButtonAnimationDuration;
            [self.layer addAnimation:fade forKey:@"borderFade"];
        }
        self.layer.borderColor = newBorderColor.CGColor;
    };
}

- (void)setSelected:(BOOL)selected
{
    [self setSelected:selected animated:YES];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [self setHighlighted:highlighted animated:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected];
    [self changeColorsForStateChangeAnimated:(BOOL)animated];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted];
    [self changeColorsForStateChangeAnimated:animated];
}

- (void)setEnabled:(BOOL)enabled animated:(BOOL)animated
{
    [super setEnabled:enabled animated:animated];
    [self changeColorsForStateChangeAnimated:animated];
}

@end

@implementation  ARClearFlatButton

- (void)setup
{
    [super setup];

    [self setBackgroundColor:[UIColor clearColor] forState:UIControlStateNormal animated:NO];
    [self setBorderColor:[UIColor whiteColor] forState:UIControlStateNormal animated:NO];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [self setBackgroundColor:[UIColor artsyPurple] forState:UIControlStateHighlighted animated:NO];
    [self setBorderColor:[UIColor artsyPurple] forState:UIControlStateHighlighted animated:NO];

}

@end


@implementation  ARWhiteFlatButton

- (void)setup
{
    [super setup];

    [self setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal animated:NO];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    [self setBackgroundColor:[UIColor blackColor] forState:UIControlStateHighlighted animated:NO];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];

    self.layer.borderWidth = 0;
}

@end

@implementation ARCircularActionButton

+ (CGFloat)buttonSize
{
    return 48;
}

- (CGSize)intrinsicContentSize
{
    return (CGSize){ 48, 48 };
}

- (instancetype)initWithImageName:(NSString *)imageName
{
    self = [super init];
    if (!self) { return nil; }

    if (imageName) {
        [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }

    CALayer *buttonLayer = self.layer;
    buttonLayer.borderColor = [UIColor artsyLightGrey].CGColor;
    buttonLayer.borderWidth = 1;
    buttonLayer.cornerRadius = [self.class buttonSize] * .5f;

    return self;
}

@end

@implementation ARNavigationTabButton

- (void)setup
{
    [super setup];
    self.alpha = 0.5;
    self.titleLabel.font = [UIFont sansSerifFontWithSize:12];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected];
    [UIView animateIf:animated withDuration:ARButtonAnimationDuration :^{
        self.alpha = selected ? 1 : 0.5;
    }];
}

@end

@implementation ARHeroUnitButton

- (void)setup
{
    [super setup];
    [self.layer setBorderWidth:2];
    self.titleLabel.font = [UIFont sansSerifFontWithSize:11];
    self.contentEdgeInsets = UIEdgeInsetsMake(10, 20, 10, 20);
    [self setBackgroundColor:[UIColor clearColor] forState:UIControlStateNormal animated:NO];
}

- (void)setColor:(UIColor *)color
{
    [self setColor:color animated:YES];
}

- (void)setColor:(UIColor *)color animated:(BOOL)animated
{
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setBorderColor:color forState:UIControlStateNormal animated:animated];
    [self setBackgroundColor:color forState:UIControlStateHighlighted animated:animated];
}

- (void)setInverseColor:(UIColor *)inverseColor
{
    [self setTitleColor:inverseColor forState:UIControlStateHighlighted];
}

@end

@implementation ARInquireButton

- (void)setup
{
    [super setup];

    self.titleLabel.font = [UIFont serifFontWithSize:16];

    [self setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [self setTitleColor:[UIColor artsyHeavyGrey] forState:UIControlStateNormal];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    NSDictionary *underlineAttribute = @{ NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle) };
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:underlineAttribute];
    self.titleLabel.attributedText = attributedTitle;
    [super setTitle:title forState:state];
}

- (CGSize)intrinsicContentSize
{
    return (CGSize){ UIViewNoIntrinsicMetric, 24 };
}

@end

@implementation ARBlackFlatButton

- (void)setup
{
    [super setup];
    
    self.titleLabel.font = [UIFont sansSerifFontWithSize:15];
    self.layer.borderWidth = 0;

    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [self setBackgroundColor:[UIColor blackColor] forState:UIControlStateNormal animated:NO];
    [self setBackgroundColor:[UIColor artsyPurple] forState:UIControlStateHighlighted animated:NO];
}

- (CGSize)intrinsicContentSize
{
    return (CGSize){ UIViewNoIntrinsicMetric, 46 };
}

@end