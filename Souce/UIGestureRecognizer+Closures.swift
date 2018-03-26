//
//  UIGestureRecognizer+Closures.swift
//  UIKit.Closures
//
//  Created by ray on 2017/12/22.
//  Copyright © 2017年 ray. All rights reserved.
//

import UIKit

fileprivate var invokerKey: UInt = 0

extension UIGestureRecognizer: Attachable {
    
    public convenience init<T: UIGestureRecognizer>(_ closure: @escaping (T) -> Void) {
        self.init()
        let invoker = Invoker<UIGestureRecognizer>(self) { sender in
            closure(sender as! T)
        }
        self.set(invoker, forKey: &invokerKey)
        self.addTarget(invoker, action: invoker.action)
    }
}

extension UIView {
    
    func whenTapped(_ enableUserInteraction: Bool = true, _ closure: @escaping (UITapGestureRecognizer) -> Void)  {
        if enableUserInteraction {
            self.isUserInteractionEnabled = true
        }
        self.addGestureRecognizer(UITapGestureRecognizer(closure))
    }
    
}
