//
//  UIGestureRecognizer+Closures.swift
//  UIKit.Closures
//
//  Created by ray on 2017/12/22.
//  Copyright © 2017年 ray. All rights reserved.
//

import UIKit

fileprivate let closureKey = "closureKey"

extension UIGestureRecognizer: Attachable {
    
    public convenience init(_ closure: @escaping (UIGestureRecognizer) -> Void) {
        self.init()
        self.addTarget(self, action: #selector(handler))
        self.set(closure, forKey: closureKey)
    }
    
    @objc func handler() {
        (self.getAttach(forKey: closureKey) as? (UIGestureRecognizer) -> Void)?(self)
    }
    
}
