//
//  Closures+Extension.swift
//  UIKit.Closures
//
//  Created by ray on 2017/12/22.
//  Copyright © 2017年 ray. All rights reserved.
//

import Foundation

class DicWrapper<K: Hashable, V> {
    var dic = [K: V]()
}

class ArrayWrapper<T> {
    var array = [T]()
}

public class Invoker<T: NSObject> {
    weak var sender: T!
    
    public var closure: (T) -> Void
    public var action: Selector {
        return #selector(invoke)
    }
    public init(_ sender: T, _ closure: @escaping (T) -> Void) {
        self.sender = sender
        self.closure = closure
    }
    @objc func invoke() {
        self.closure(sender)
    }
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
