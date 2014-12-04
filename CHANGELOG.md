# Artsy-UIButtons CHANGELOG

## 1.3.0

* Updated to use new UIView+BooleanAnimations pod as a depedency (#2).

## 1.2.0
* Ability to toggle whether changes that happen automatically with state change (color, alpha) should be animated, without having to override the state setter methods in subclasses. `shouldAnimateStateChange` defaults to YES.
* Ability to toggle whether or not a Disabled button should be at 50% alpha. `shouldDimWhenDisabled` defaults to YES.
* Added generic underline button that may be subclassed
## 1.1.0
* Initial release.
