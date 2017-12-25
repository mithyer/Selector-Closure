//
//  UIBarButtonItem+Closures.swift
//  UIKit.Closures
//
//  Created by ray on 2017/12/22.
//  Copyright © 2017年 ray. All rights reserved.
//

import UIKit

fileprivate class Target {
    
    var closure: (UIBarButtonItem?) -> Void
    weak var item: UIBarButtonItem?
    
    init(_ closure: @escaping (UIBarButtonItem?) -> Void) {
        self.closure = closure
    }
    
    @objc func handler() {
        self.closure(item)
    }
}

fileprivate var targetKey: UInt = 0

extension UIBarButtonItem: Attachable {

    public convenience init(image: UIImage?, style: UIBarButtonItemStyle, _ closure: @escaping (UIBarButtonItem?) -> Void) {
        let target = Target(closure)
        self.init(image: image, style: style, target: target, action: #selector(Target.handler))
        target.item = self
        self.set(target, forKey: &targetKey)
    }
    
    public convenience init(image: UIImage?, landscapeImagePhone: UIImage?, style: UIBarButtonItemStyle, _ closure:  @escaping (UIBarButtonItem?) -> Void) {
        let target = Target(closure)
        self.init(image: image, landscapeImagePhone: landscapeImagePhone, style: style, target: target, action: #selector(Target.handler))
        target.item = self
        self.set(target, forKey: &targetKey)
    }
    
    public convenience init(title: String?, style: UIBarButtonItemStyle, _ closure: @escaping (UIBarButtonItem?) -> Void) {
        let target = Target(closure)
        self.init(title: title, style: style, target: target, action: #selector(Target.handler))
        target.item = self
        self.set(target, forKey: &targetKey)
    }
    
    public convenience init(barButtonSystemItem systemItem: UIBarButtonSystemItem, _ closure: @escaping (UIBarButtonItem?) -> Void) {
        let target = Target(closure)
        self.init(barButtonSystemItem: systemItem, target: target, action: #selector(Target.handler))
        target.item = self
        self.set(target, forKey: &targetKey)
    }

}
