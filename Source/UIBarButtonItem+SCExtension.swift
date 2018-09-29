//
//  UIBarButtonItem+Closures.swift
//  UIKit.Closures
//
//  Created by ray on 2017/12/22.
//  Copyright © 2017年 ray. All rights reserved.
//

import UIKit

fileprivate var invokerKey: Void?

extension UIBarButtonItem: SCExtension {
    
    func initInvoker<T: UIBarButtonItem>(_ closure: @escaping (T) -> Void) {
        let invoker = Invoker(self as! T, closure)
        self.sce.set(invoker, forKey: &invokerKey)
        self.target = invoker
        self.action = invoker.action
    }
}

extension SCECls where T: UIBarButtonItem {
    
    static public func initialize(image: UIImage?, style: UIBarButtonItem.Style, _ closure: @escaping (T) -> Void) -> T {
        let btnItem = T.init(image: image, style: style, target: nil, action: nil)
        btnItem.initInvoker(closure)
        return btnItem
    }
    
    static public func initialize(title: String?, style: UIBarButtonItem.Style, _ closure: @escaping (T) -> Void) -> T {
        let btnItem = T.init(title: title, style: style, target: nil, action: nil)
        btnItem.initInvoker(closure)
        return btnItem
    }
    
    static public func initialize(barButtonSystemItem systemItem: UIBarButtonItem.SystemItem, _ closure: @escaping (T) -> Void) -> T {
        let btnItem = T.init(barButtonSystemItem: systemItem, target: nil, action: nil)
        btnItem.initInvoker(closure)
        return btnItem
    }
    
    static public func initialize(customView: UIView, _ closure: @escaping (T) -> Void) -> T {
        let btnItem = T.init(customView: customView)
        btnItem.initInvoker(closure)
        return btnItem
    }
    
    public func sendAction() {
        if let target = self.object?.target, let action = self.object?.action {
            _ = target.perform(action)
        }
    }
}


