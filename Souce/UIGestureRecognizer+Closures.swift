//
//  UIGestureRecognizer+Closures.swift
//  UIKit.Closures
//
//  Created by ray on 2017/12/22.
//  Copyright © 2017年 ray. All rights reserved.
//

import UIKit

fileprivate var closureKey: UInt = 0

extension UIGestureRecognizer: Attachable {
    
    public convenience init<T: UIGestureRecognizer>(_ closure: @escaping (T) -> Void) {
        self.init()
        self.addTarget(self, action: #selector(handler))
        self.set(ClosureWrapper<T>(closure), forKey: &closureKey)
    }
    
    @objc func handler() {
        (self.getAttach(forKey: &closureKey) as? ClosureWrapper<UIGestureRecognizer>)?.closure(self)
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
