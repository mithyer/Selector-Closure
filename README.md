# Selector-Closure
[![Swift32][swift32-badge]][swift-url]
[![Swift4][swift4-badge]][swift-url]
[![Platform][platform-badge]][platform-url]

**Selector-Closure** is a light way to convert objc target-action selector to closure style

# Version 1.x.x

Type of Object calling "sce" will be auto recognized in closure

## UIControl

**use ".sce" to make closure callback**

```swift
let btn = UIButton()
let field = UITextField()

// for specific event 
_ = btn.sce.add(.touchUpInside) { sender in
  // ... sender is UIButton
}

// for default event(UIButton, UISwitch, UISlider, UITextField has default events)
let invoker = field.sce.add { sender in
  // ... sender is UITextField
}

// now you can remove action with invoker returned
field.sce.remove(invoker)

// remove all for events
field.sce.removeAll(.touchUpInside) { sender in
  // ...
}

// test didAdd events
let res: Bool = field.sce.didAdd(.touchUpInside)
```


## UIBarButtonItem

**use ".SCE" to initialize**

```swift
let item = UIBarButtonItem.SCE.initialize(title: "test", style: .plain, { item in
  // ...
})

// ...
```

## UIGestureRecognizer

**use ".SCE" to initialize**

```swift
// init a recognizer, 
let tgr = UITapGestureRecognizer.SCE.initialize { tgr in
  // tgr is UITapGestureRecognizer
}

let sgr = UISwipeGestureRecognizer.SCE.initialize { sgr in
  // sgr is UISwipeGestureRecognizer
}
```

## UIView

**use ".sce" to make closure callback**

```swift
// fast make tap action
let view = UIView()
let tapGestureRecognizer = view.sce.whenTapped { tgr in
  // tgr === tapGestureRecognizer
}
```


## Convert your own

```swift
// you have an instance named obj
let invoker = Invoker(obj) { obj in
  // ...
}
let act = invoker.action // convert done, now pass invoker to target, act to action
```
[swift32-badge]: https://img.shields.io/badge/Swift-3.2-orange.svg?style=flat
[swift4-badge]: https://img.shields.io/badge/Swift-4.0-orange.svg?style=flat
[swift-url]: https://swift.org
[platform-badge]: https://img.shields.io/badge/platform-iOS%20%7C%20macOS%20%7C%20watchOS%20%7C%20tvOS%20%7C%20Linux-lightgrey.svg
[platform-url]: https://developer.apple.com/swift/