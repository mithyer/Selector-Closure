//
//  UIView+SCExtension.swift
//  Selector-Closure.Demo
//
//  Created by ray on 2018/4/13.
//  Copyright © 2018年 ray. All rights reserved.
//

import UIKit

extension UIView: SCExtension {}

extension SCECls where T: UIView {
    
    public func whenTapped(_ enableUserInteraction: Bool = true, _ closure: @escaping (UITapGestureRecognizer) -> Void) -> UITapGestureRecognizer  {
        let view = self.object!
        if enableUserInteraction {
            view.isUserInteractionEnabled = true
        }
        let recg = UITapGestureRecognizer.SCE.initialize(closure)
        view.addGestureRecognizer(recg)
        return recg
    }
}
