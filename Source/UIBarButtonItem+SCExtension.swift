//
//  UIBarButtonItem+Closures.swift
//  UIKit.Closures
//
//  Created by ray on 2017/12/22.
//  Copyright © 2017年 ray. All rights reserved.
//

import UIKit

fileprivate var invokerKey = 0

extension UIBarButtonItem: AddSCE {
    
    static let sce = SCE(UIBarButtonItem.self)

    func initInvoker(_ closure: @escaping (UIBarButtonItem) -> Void) {
        let invoker = Invoker<UIBarButtonItem>(self, closure)
        self.sce.set(invoker, forKey: &invokerKey)
        self.target = invoker
        self.action = invoker.action
    }
}

extension SCE where Element == UIBarButtonItem {
    
    public func sendAction() {
        if let target = self.object?.target, let action = self.object?.action {
            _ = target.perform(action)
        }
    }
}

extension SCE where Element == UIBarButtonItem.Type {
    
    
    public func initialize(image: UIImage?, style: UIBarButtonItemStyle, _ closure: @escaping (UIBarButtonItem) -> Void) -> UIBarButtonItem {
        let btnItem = self.object!.init(image: image, style: style, target: nil, action: nil)
        btnItem.initInvoker(closure)
        return btnItem
    }
    
    public func initialize(title: String?, style: UIBarButtonItemStyle, _ closure: @escaping (UIBarButtonItem) -> Void) -> UIBarButtonItem {
        let btnItem = UIBarButtonItem.init(title: title, style: style, target: nil, action: nil)
        btnItem.initInvoker(closure)
        return btnItem
    }
    
    public func initialize(barButtonSystemItem systemItem: UIBarButtonSystemItem, _ closure: @escaping (UIBarButtonItem) -> Void) -> UIBarButtonItem {
        let btnItem = UIBarButtonItem.init(barButtonSystemItem: systemItem, target: nil, action: nil)
        btnItem.initInvoker(closure)
        return btnItem
    }
    
    public func initialize(customView: UIView, _ closure: @escaping (UIBarButtonItem) -> Void) -> UIBarButtonItem {
        let btnItem = UIBarButtonItem.init(customView: customView)
        btnItem.initInvoker(closure)
        return btnItem
    }
    
}


