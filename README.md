# Selector-Closure
A light way to convert objc target-action selector to closure style by Swift3/4


## UIControl

```
// add events
control.add(.touchUpInside) { sender in
  // ...
}

// or like this to convert type of control
control.add(.touchUpInside) { (sender: UIButton) in
  // ...
}

// or use default event(UIButton, UISwitch, UISlider, UITextField has default events)
let invoker = control.add { (btn: UIButton) in
  // ...
}

// now you can remove specific closure with invoker returned
control.remove(invoker)

// remove all for events
control.removeAll(.touchUpInside) { sender in
  // ...
}

// test didAdd events
let res: Bool = control.didAdd(.touchUpInside)
```


## UIBarButtonItem

```
let item = UIBarButtonItem.init(title: "test", style: .plain, { item in
  // ...
})

// ...
```

## UIGestureRecognizer

```
// init a recognizer
let r = UITapGestureRecognizer{ recognizer in
  // ...
}

// fast make tap action
let view = UIView()
let r: UITapGestureRecognizer = view.whenTapped { recognizer in
    // ...
}
```


## Convert your own

```
// you have an instance named obj
let invoker = Invoker(obj) { obj in
  // ...
}
let act = invoker.action // convert done, now pass invoker to target, act to action
```
