![ShyView: A UI component that avoid schreenshots and recordings](https://raw.githubusercontent.com/MarioIannotta/ShyView/main/Resources/ShyView.jpg)

# ShyView

[![SwiftPM 5.3](https://img.shields.io/badge/SwiftPM-5.6-ED523F.svg?style=flat)](https://swift.org/download/) [![Version](https://img.shields.io/cocoapods/v/ShyView.svg?style=flat)](https://cocoapods.org/pods/ShyView) [![License](https://img.shields.io/cocoapods/l/ShyView.svg?style=flat)](https://cocoapods.org/pods/ShyView) [![Platform](https://img.shields.io/cocoapods/p/ShyView.svg?style=flat)](https://cocoapods.org/pods/ShyView)

<img src="https://raw.githubusercontent.com/MarioIannotta/ShyView/main/Resources/Demo.gif" height="500"/>

## Installation

ShyView is available through SwiftPM.

### SwiftPM

Add the package to your dependencies

```swift
.package(
  name: "ShyView",
  url: "https://github.com/MarioIannotta/ShyView.git",
  .upToNextMinor("0.2.0")
)
```

Add package product to your targets

```swift
.product(
  name: "ShyView",
  package: "ShyView"
)
```

### Pods

ShyView is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

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
// Configure layout for topSecretLabel
```

There is also a helper for the implicit content protection

```swift
let topSecretLabel = UILabel()
topSecretLabel.text = "4, 8, 15, 16, 23, 42"

view.addSubview(topSecretLabel.avoidScreenshots())
// Configure layout for topSecretLabel
```

Or use `ShyView` as a container for some custom content

```swift
let topSecretLabel = UILabel()
topSecretLabel.text = "4, 8, 15, 16, 23, 42"

let shyView = ShyView()
view.addSubview(shyView)
shyView.contentView.addSubview(topSecretLabel)
// Configure layout for shyView, topSecretLabel
// and any other added views independently
```

## Disclaimer

This component, is build upon a UITextField "hack, use it at your own risk.

## License

ShyView is available under the MIT license. See the [LICENSE](./LICENSE) file for more info.

## Author

[@MarioIannotta](https://twitter.com/marioiannotta), info@marioiannotta.com
