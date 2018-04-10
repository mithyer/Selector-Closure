//
//  UIGestureRecognizer+Closures.swift
//  UIKit.Closures
//
//  Created by ray on 2017/12/22.
//  Copyright © 2017年 ray. All rights reserved.
//

import UIKit

fileprivate var invokerKey = 0


extension UIGestureRecognizer: AddSCE {

    static let sce = SCE(UIGestureRecognizer.self)
    
}

extension SCE where Element == UIGestureRecognizer.Type {
    
    
    public func initialize<T: UIGestureRecognizer>(_ closure: @escaping (T) -> Void) -> T {
        let recg = T.init()
        let invoker = Invoker(recg, closure)
        recg.sce.set(invoker, forKey: &invokerKey)
        recg.addTarget(invoker, action: invoker.action)
        return recg
    }
}

extension SCE where Element: UIView {
    
    public func whenTapped(_ enableUserInteraction: Bool = true, _ closure: @escaping (UITapGestureRecognizer) -> Void) -> UITapGestureRecognizer  {
        let view = self.object!
        if enableUserInteraction {
            view.isUserInteractionEnabled = true
        }
        let recg = UITapGestureRecognizer.sce.initialize(closure)
        view.addGestureRecognizer(recg)
        return recg
    }
}


