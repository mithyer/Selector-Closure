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
    
    func set(_ attachObj: Any?, forKey key: inout UInt)
    func getAttach(forKey key: inout UInt) -> Any?
    
}

extension Attachable {
    
    public func set(_ attachObj: Any?, forKey key: inout UInt) {
        objc_setAssociatedObject(self, &key, attachObj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    public func getAttach(forKey key: inout UInt) -> Any? {
        return objc_getAssociatedObject(self, &key)
    }
}
