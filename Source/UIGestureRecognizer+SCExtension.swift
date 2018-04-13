//
//  UIGestureRecognizer+Closures.swift
//  UIKit.Closures
//
//  Created by ray on 2017/12/22.
//  Copyright © 2017年 ray. All rights reserved.
//

import UIKit

fileprivate var invokerKey: Void?

extension UIGestureRecognizer: SCExtension {}

extension SCECls where T: UIGestureRecognizer {
    
    static public func initialize(_ closure: @escaping (T) -> Void) -> T {
        let recg = T.init()
        let invoker = Invoker(recg, closure)
        recg.sce.set(invoker, forKey: &invokerKey)
        recg.addTarget(invoker, action: invoker.action)
        return recg
    }
}


