//
//  RYExtension.swift
//  UIKit.Closures
//
//  Created by ray on 2017/12/22.
//  Copyright © 2017年 ray. All rights reserved.
//

import Foundation

class DicBox<K: Hashable, V> {
    var dic = [K: V]()
}

class ArrayBox<T> {
    var array = [T]()
}

public protocol Attachable {
    
    func set(_ attachObj: Any?, forKey key: String)
    func getAttach(forKey key: String) -> Any?
    
}

private var boxKey: UInt8 = 0

extension Attachable {
    
    public func set(_ attachObj: Any?, forKey key: String) {
        let sSelf = self
        if nil == attachObj {
            if let box = objc_getAssociatedObject(self, &boxKey) as? DicBox<String, Any> {
                box.dic.removeValue(forKey: key)
            }
            return
        }
        if let box = objc_getAssociatedObject(self, &boxKey) as? DicBox<String, Any> {
            box.dic[key] = attachObj!
        } else {
            let box = DicBox<String, Any>()
            objc_setAssociatedObject(sSelf, &boxKey, box, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            box.dic[key] = attachObj!
        }
    }
    
    public func getAttach(forKey key: String) -> Any? {
        guard let box = objc_getAssociatedObject(self, &boxKey) as? DicBox<String, Any> else {
            return nil
        }
        return box.dic[key]
    }
}
