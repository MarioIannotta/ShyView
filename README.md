![ShyView: A UI component that avoid schreenshots and recordings](https://raw.githubusercontent.com/MarioIannotta/ShyView/main/Resources/ShyView.jpg)

# ShyView

[![Version](https://img.shields.io/cocoapods/v/ShyView.svg?style=flat)](https://cocoapods.org/pods/ShyView)
[![License](https://img.shields.io/cocoapods/l/ShyView.svg?style=flat)](https://cocoapods.org/pods/ShyView)
[![Platform](https://img.shields.io/cocoapods/p/ShyView.svg?style=flat)](https://cocoapods.org/pods/ShyView)

<img src="https://raw.githubusercontent.com/MarioIannotta/ShyView/main/Resources/Demo.gif" height="500"/>

## Installation

ShyView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

### Pods
```ruby
pod 'ShyView'
```

## Usage

Simply Wrap the view you want not to be screenshotted (or recorded) in a `ShyView`.

```swift
let topSecretLabel = UILabel()
topSecretLabel.text = "4, 8, 15, 16, 23, 42"

let shyView = ShyView(topSecretLabel)
view.addSubview(topSecretLabel)
```

## Disclaimer

This component, is build upon a UITextField; use it at your own risk.

## License

ShyView is available under the MIT license. See the LICENSE file for more info.

## Author

[@MarioIannotta](https://twitter.com/marioiannotta), info@marioiannotta.com