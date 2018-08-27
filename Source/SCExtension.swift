//
//  Selector-Closureswift
//  UIKit.Closures
//
//  Created by ray on 2017/12/22.
//  Copyright © 2017年 ray. All rights reserved.
//

import UIKit


public class Invoker<T: AnyObject> {
    
    weak var sender: T?
    
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
        if let sender = self.sender {
            self.closure(sender)
        }
    }
}

public class SCECls<T: AnyObject> {
    
    weak public var object: T?
    
    init(_ object: T) {
        self.object = object
    }
    
    func set(_ attachObj: Any?, forKey key: inout Void?) {
        objc_setAssociatedObject(self, &key, attachObj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func getAttach<K>(forKey key: inout Void?) -> K? {
        return objc_getAssociatedObject(self, &key) as? K
    }
}

public protocol SCExtension {
    
    associatedtype T: AnyObject

    static var SCE: SCECls<T>.Type { get }
    var sce: SCECls<T> { get }
}

fileprivate var sceKey: Void?

extension SCExtension where Self: AnyObject & SCExtension {
    
    public static var SCE: SCECls<Self>.Type {
        return SCECls<Self>.self
    }
    
    public var sce: SCECls<Self> {
        return objc_getAssociatedObject(self, &sceKey) as? SCECls<Self> ?? {
            let sce = SCECls<Self>(self)
            objc_setAssociatedObject(self, &sceKey, sce, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return sce
        }()
    }
}

