# UIKit.Closures
A light way to make target-action to closure in Swift.UIKit with Swift4

## UIControl

```
// add events
control.add(.touchUpInside) { sender in
  // action
}

// or like this to convert type of control
control.add(.touchUpInside) { (sender: UIButton) in
  // action
}
// or use default event(UIButton, UISwitch, UISlider, UITextField has default events)
control.add { (btn: UIButton) in
  // action
}

// remove events
control.remove(.touchUpInside) { sender in
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
// init a recognizer
let r = UITapGestureRecognizer{ recognizer in
  // action
}

// fast make tap action
let view = UIView()
view.whenTapped { recognizer in
  
}

......

```



code style is more like 

[BlocksKit](https://github.com/BlocksKit/BlocksKit) 

than 

[Closures](https://github.com/vhesener/Closures)
