SMABannerView
=====================================
![Badge w/ Version](https://cocoapod-badges.herokuapp.com/v/SMABannerView/badge.png)
![Badge w/ Version](https://cocoapod-badges.herokuapp.com/p/SMABannerView/badge.png)

An easy to use banner view with title and message for all your iOS projects.

##RELEASE 1.0
This is the first iteration of this library and works as expected. We needed a simple messaging system for our tvOS app and this is what we came up with. It worked so simple that we decided to share it. It doesn't have "everything", but is pretty close. If you have any suggestions, we welcome feedback and pull requests.

##Installation

**Cocoapods**

<code>pod 'SMABannerView'</code>

**Manual Installation**

Include the `SMABannerView.swift` file in your project.

##Example
``` swift
let banner = SMABannerView(title: "Simple Title", message: "Simple message to display", view: self.view)
banner.show()
```
You can fully customize the banner in any way before calling `show()`. All of the properties are public and allow you to override the defaults to format things any way you want.

``` swift
banner.titleString = "Some Title"
banner.titleFont = UIFont.systemFontOfSize(24)
banner.titleColor = UIColor.blackColor()
banner.messageString = "Some message to display"
banner.messageFont = UIFont.systemFontOfSize(18)
banner.messageColor = UIColor.blackColor()

banner.alignment = .Center // takes SMABannerAlignment enum

banner.titlePaddingTop = 15.0
banner.paddingLeft = 40.0 // title and message padding
banner.paddingRight = 40.0 // title and message padding
banner.messagePaddingBottom = 10.0

banner.animationDuration = 0.3
banner.opacity = 0.8
banner.bannerHeight = 100.0

banner.isShowing
banner.isAnimating
```

##Requirements
SMABannerView requires iOS 8 or later. We will exand support as needed if it doesn't affect anything negatively. If you need this for something older, please submit a pull request.
* iOS 8.0 or later
* tvOS 9.0 or later

##Credits
SMABannerView was written for use in projects created by [Simply Made Apps](https://www.simpleinout.com).

##Creator
[Bill Burgess](https://github.com/billburgess) [@billburgess](https://twitter.com/billburgess)

##License
SMABannerView is available under the MIT license. See the LICENSE file for more information.

##What's Next
* Expand test coverage completely
