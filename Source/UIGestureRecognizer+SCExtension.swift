//
//  UIGestureRecognizer+Closures.swift
//  UIKit.Closures
//
//  Created by ray on 2017/12/22.
//  Copyright © 2017年 ray. All rights reserved.
//

import UIKit

fileprivate var invokerKey = 0

extension UIGestureRecognizer: AddSCE {}

extension UIGestureRecognizer {
    
    public static func sce_init<T: UIGestureRecognizer>(_ closure: @escaping (T) -> Void) -> T {
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
        let recg = UITapGestureRecognizer.sce_init(closure)
        view.addGestureRecognizer(recg)
        return recg
    }
}
