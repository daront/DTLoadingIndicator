DTLoadingIndicator
===========

[![Badge w/ Version](http://cocoapod-badges.herokuapp.com/v/DTLoadingIndicator/badge.png)](http://cocoadocs.org/docsets/DTLoadingIndicator)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat
)](http://mit-license.org)
[![Platform](https://img.shields.io/cocoapods/p/DTImageScrollView.svg?style=flat)](http://cocoadocs.org/docsets/DTLoadingIndicator)

Easily show/hide a loading indicator in fullscreen or a specific view.

![](screenshot1.png)
                    
## Features
* Show full screen standard loading indicator (This will disable user interaction).
* Show standard loading indicator in a center of specific view.
* Show full screen loading indicator with **animated gif** (This will disable user interaction).
* Show standard loading indicator with **animated gif** in a specific view.

## System Requirements
iOS 8.0+, Swift 3.0

## Installation

### CocoaPods

Add into your Podfile.

```:Podfile
pod "DTLoadingIndicator"
```

Then `$ pod install`

## How to use

Just call `DTLoadingIndicator.startFullScreenLoadingIndicator()`, `DTLoadingIndicator.startGiftFullScreenLoadingIndicator()`, `DTLoadingIndicator.startLoadingIndicatorInView()`, `DTLoadingIndicator.startLoadingIndicatorInView.startGiftLoadingIndicatorInView()` to show loading indicator.
Call `DTLoadingIndicator.stopXxxxxx()` to hide it.

```swift
DTLoadingIndicator.startGiftFullScreenLoadingIndicator()
DTLoadingIndicator.stopFullScreenLoadingIndicator()
```

or 

```swift
DTLoadingIndicator.startGiftLoadingIndicatorInView(self.contentView, top: 30)
DTLoadingIndicator.stopLoadingIndicatorInView(self.contentView)
```

See more detail in the demo project.

## Customizations

Currently, it's not possible to change animated gif image yet. Please feel free to contribute.
You can also just download and replace the gif file with your own.

## Author

**Daron Tancharoen**

- CONTACTS:
  - [Email](daront@gmail.com)

## License
DTLoadingIndicator is licensed under the MIT License, please see the [LICENSE](LICENSE) file.

