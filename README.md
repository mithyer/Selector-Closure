# UIKit.Closures
a light way to make target-action to closure in Swift.UIKit with Swift4

## UIControl

```
// add events
control.add(.touchUpInside) { btn in
  // action
}

// remove events
control.remove(.touchUpInside) { btn in
  // action
}

// test didAdd events
let res: Bool = control.didAdd(.touchUpInside)

```


## UIBarButtonItem

```
let item = UIBarButtonItem.init(title: "test", style: .plain, { item in
   // action
})

...

...

...
```

## UIGestureRecognizer

```
let r = UITapGestureRecognizer{ recognizer in
  // action
}

......

```


code style is more like 

[BlocksKit](https://github.com/BlocksKit/BlocksKit) 

than 

[Closures](https://github.com/vhesener/Closures)
