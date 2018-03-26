//
//  UIBarButtonItem+Closures.swift
//  UIKit.Closures
//
//  Created by ray on 2017/12/22.
//  Copyright © 2017年 ray. All rights reserved.
//

import UIKit

fileprivate var invokerKey: UInt = 0

extension UIBarButtonItem: Attachable {

    public convenience init(image: UIImage?, style: UIBarButtonItemStyle, _ closure: @escaping (UIBarButtonItem) -> Void) {
        self.init(image: image, style: style, target: nil, action: nil)
        self.initInvoker(closure)
    }
    
    public convenience init(image: UIImage?, landscapeImagePhone: UIImage?, style: UIBarButtonItemStyle, _ closure:  @escaping (UIBarButtonItem) -> Void) {
        self.init(image: image, landscapeImagePhone: landscapeImagePhone, style: style, target: nil, action: nil)
        self.initInvoker(closure)
    }
    
    public convenience init(title: String?, style: UIBarButtonItemStyle, _ closure: @escaping (UIBarButtonItem) -> Void) {
        self.init(title: title, style: style, target: nil, action: nil)
        self.initInvoker(closure)
    }
    
    public convenience init(barButtonSystemItem systemItem: UIBarButtonSystemItem, _ closure: @escaping (UIBarButtonItem) -> Void) {
        self.init(barButtonSystemItem: systemItem, target: nil, action: nil)
        self.initInvoker(closure)
    }
    
    public convenience init(customView: UIView, _ closure: @escaping (UIBarButtonItem) -> Void) {
        self.init(customView: customView)
        self.initInvoker(closure)
    }

    func initInvoker(_ closure: @escaping (UIBarButtonItem) -> Void) {
        let invoker = Invoker<UIBarButtonItem>(self, closure)
        self.set(invoker, forKey: &invokerKey)
        self.target = invoker
        self.action = invoker.action
    }
    
}
