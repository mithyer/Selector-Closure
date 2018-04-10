# Selector-Closure

A light way to convert objc target-action selector to closure style by Swift3/4

# Version 1.x.x

Now type of UIControl can be auto recognized.
Use "sce" prefix to use all function.


## UIControl

```
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

```
let item = UIBarButtonItem.sce.initialize(title: "test", style: .plain, { item in
  // ...
})

// ...
```

## UIGestureRecognizer

```
// init a recognizer, 
// notice: GestureRecognizer need assign type

let r: UITapGestureRecognizer = UITapGestureRecognizer.sce.initialize { recognizer in
  // ...
}

// fast make tap action
let view = UIView()
let tapGestureRecognizer = view.sce.whenTapped { recognizer in
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
