//
//  Selector-Closureswift
//  UIKit.Closures
//
//  Created by ray on 2017/12/22.
//  Copyright © 2017年 ray. All rights reserved.
//

import UIKit

class DicWrapper<K: Hashable, V> {
    
    var dic = [K: V]()
}

class ArrayWrapper<T> {
    
    var array = [T]()
}

public class Invoker<T: NSObject> {
    
    weak var sender: T!
    
    var events: UIControlEvents?
    
    var closure: (T) -> Void
    
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

public class SCE<Element: NSObject> {
    
    public weak var object: Element?

    init(_ object: Element) {
        self.object = object
    }

    func set(_ attachObj: Any?, forKey key: inout Int) {
        objc_setAssociatedObject(self, &key, attachObj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    func getAttach<T>(forKey key: inout Int) -> T? {
        return objc_getAssociatedObject(self, &key) as? T
    }
}

public protocol AddSCE {
    
    associatedtype T: NSObject
    
    var sce: SCE<T> { get }
}

fileprivate var sceKey = 0

extension AddSCE where Self: NSObject {
    
    public var sce: SCE<Self> {
        return objc_getAssociatedObject(self, &sceKey) as? SCE ?? {
            let sce = SCE<Self>(self)
            objc_setAssociatedObject(self, &sceKey, sce, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return sce
        }()
    }
}

extension UIView: AddSCE {}

