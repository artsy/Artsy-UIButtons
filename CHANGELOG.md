# Artsy-UIButtons CHANGELOG

## 2.3.0

* All ARFlatButtons now use sentence case, default to 50px in height and use Unica sans

## 2.2.3

* ARClearFlatButton now has a two pixel width instead of a single pixel

## 2.2.2

*  Changes the disabled transparency in all ARFlatButtons

## 2.2.1

*  Changes the font size in all buttons

## 2.0.3

* Fixes for CocoaPods 1.0 dependency resolver and OSS fonts.

## 1.4.0

* Add `-[ARUnderlineButton setUnderlinedTitle:underlineRange:state]` to easily set a title with partial underline.
* Fix a partial underline bug on iOS >= 8.0 && < 8.3

## 1.3.0

* Updated to use new UIView+BooleanAnimations pod as a dependency (#2).

## 1.2.0
* Ability to toggle whether changes that happen automatically with state change (color, alpha) should be animated,
  without having to override the state setter methods in subclasses. `shouldAnimateStateChange` defaults to YES.
* Ability to toggle whether or not a Disabled button should be at 50% alpha. `shouldDimWhenDisabled` defaults to YES.
* Added generic underline button that may be subclassed
## 1.1.0
* Initial release.
