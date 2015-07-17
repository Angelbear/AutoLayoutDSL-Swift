# AutoLayoutDSL-Swift
AutoLayoutDSL-Swift is a straightforward swift DSL/extension for more convinient auto layout management

## Features

- [x] Mathematical operations +, -, *, /, ==, >=, <= for creating NSAutoLayoutConstraint
- [x] Convinient infix operations =>, ~~>, ~~~> for adding constraints in chain mode

## Requirements

- iOS 7.0+
- Xcode 6.3

## Communication

- If you **need help**, use [Stack Overflow](http://stackoverflow.com/).
- If you'd like to **ask a general question**, use [Stack Overflow](http://stackoverflow.com/).
- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Installation

> **Embedded frameworks require a minimum deployment target of iOS 8
>
> To use AutoLayoutDSL-Swift with a project targeting iOS 7, you must include all Swift files located inside the `Source` directory directly in your project. See the ['Source File'](#source-file) section for additional instructions.

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.

CocoaPods 0.36 adds supports for Swift and embedded frameworks. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate AutoLayoutDSL-Swift into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'AutoLayoutDSL-Swift', '~> 1.0.0'
```

Then, run the following command:

```bash
$ pod install
```

---

## Usage

### Create an NSLayoutConstraints

```swift
import AutoLayoutDSL-Swift

view.left == parentView.left + 10
// is equal to 
NSLayoutConstraint(item: view, attribute: .Left, relatedBy: .Equal, toItem: parentView, attribute: .Left, multiplier: 1, constant:10


view.right >= parentView.right - 10
// is equal to 
NSLayoutConstraint(item: view, attribute: .Right, relatedBy: .GreaterThanOrEqual, toItem: parentView, attribute: .Right, multiplier: 1, constant:- 10

view.height == anotherView.height * 2
// is equal to 
NSLayoutConstraint(item: view, attribute: .Height, relatedBy: .Equal, toItem: anotherView, attribute: .Height, multiplier: 2, constant:0

view.height == anotherView.height / 2
// is equal to 
NSLayoutConstraint(item: view, attribute: .Height, relatedBy: .Equal, toItem: anotherView, attribute: .Height, multiplier: 0.5, constant:0


view.height == 100
// is equal to 
NSLayoutConstraint(item: view, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant:100
```

### Add NSLayoutConstraints

```swift
// 4 NSLayoutConstraints were added and all their priority will be UILayoutPriorityRequired
self.view => self.redView.left == self.view.left + 10
        => self.redView.right == self.view.right - 10
        => self.redView.top == self.view.top + 30
        => self.redView.height == 100
        
// 4 NSLayoutConstraints were added 
// First two constraints' priorities will be UILayoutPriorityRequired
// Third constraint‘s priority will be UILayoutPriorityDefaultHigh
// Fourth constraint's priority will be UILayoutPriorityDefaultLow
self.view => self.redView.left == self.view.left + 10
        => self.redView.right == self.view.right - 10
        ~~> self.redView.top == self.view.top + 30
        ~~~> self.redView.height == 100
        
// If you want custom priority, you can write as belowing
var constaint = self.redView.left == self.view.left + 10
constraint.priority = UILayoutPriorityDefaultHigh - 1
self.view => constraint // => doesn't change priority
```

* * *

## FAQ

### When should I use AutoLayoutDSL-Swift?

If you are writting iOS project with Swift, and you want to create UI by manually writting code instead of using Storyboar, but you still want to take the advantage of AutoLayout to save you do the math for calculating the frame, and use automatically handling dynamic content, AutoLayoutDSL-Swift may be one of your choice to save a lot of lines creating instance of NSLayoutConstraint, also let the code to be more cleaner and more straightforward.

* * *

## Acknowledgement

AutoLayoutDSL-Swift is inspired by [AutoLayoutDSL](http://github.com/humblehacker/AutoLayoutDSL), yet [AutoLayoutDSL](http://github.com/humblehacker/AutoLayoutDSL) is written in Objective C++.

## License

AutoLayoutDSL-Swift is released under the MIT license. See LICENSE for details.
