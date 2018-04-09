//
//  UIBarButtonItem+Closures.swift
//  UIKit.Closures
//
//  Created by ray on 2017/12/22.
//  Copyright © 2017年 ray. All rights reserved.
//

import UIKit

fileprivate var invokerKey = 0

extension UIBarButtonItem: AddSCE {}

extension UIBarButtonItem {
    
    public static func sce_init(image: UIImage?, style: UIBarButtonItemStyle, _ closure: @escaping (UIBarButtonItem) -> Void) -> Self {
        let btnItem = self.init(image: image, style: style, target: nil, action: nil)
        btnItem.initInvoker(closure)
        return btnItem
    }
    
    public static func sce_init(image: UIImage?, landscapeImagePhone: UIImage?, style: UIBarButtonItemStyle, _ closure:  @escaping (UIBarButtonItem) -> Void) -> Self {
        let btnItem = self.init(image: image, landscapeImagePhone: landscapeImagePhone, style: style, target: nil, action: nil)
        btnItem.initInvoker(closure)
        return btnItem
    }
    
    public static func sce_init(title: String?, style: UIBarButtonItemStyle, _ closure: @escaping (UIBarButtonItem) -> Void) -> Self {
        let btnItem = self.init(title: title, style: style, target: nil, action: nil)
        btnItem.initInvoker(closure)
        return btnItem
    }
    
    public static func sce_init(barButtonSystemItem systemItem: UIBarButtonSystemItem, _ closure: @escaping (UIBarButtonItem) -> Void) -> Self {
        let btnItem = self.init(barButtonSystemItem: systemItem, target: nil, action: nil)
        btnItem.initInvoker(closure)
        return btnItem
    }
    
    public static func sce_init(customView: UIView, _ closure: @escaping (UIBarButtonItem) -> Void) -> Self {
        let btnItem = self.init(customView: customView)
        btnItem.initInvoker(closure)
        return btnItem
    }
    
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
