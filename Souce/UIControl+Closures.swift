//
//  UIControl+Closures.swift
//  UIKit.Closures
//
//  Created by ray on 2017/12/19.
//  Copyright © 2017年 ray. All rights reserved.
//

import UIKit

fileprivate typealias InvokersDicWrapper = DicWrapper<UInt, ArrayWrapper<Invoker<UIControl>>>
fileprivate var invokersDicWrapperKey: UInt = 0

extension UIControl: Attachable {

    fileprivate func invokers(forEvents events: UIControlEvents, createIfNotExist: Bool = true) -> ArrayWrapper<Invoker<UIControl>>? {
        let dicWrapper: InvokersDicWrapper? = self.getAttach(forKey: &invokersDicWrapperKey) as? InvokersDicWrapper ?? {
            if !createIfNotExist {
                return nil
            }
            let wrapper = InvokersDicWrapper()
            self.set(wrapper, forKey: &invokersDicWrapperKey)
            return wrapper
        }()
        if nil == dicWrapper {
            return nil
        }
        let invokers: ArrayWrapper<Invoker<UIControl>>? = dicWrapper!.dic[events.rawValue] ?? {
            if !createIfNotExist {
                return nil
            }
            let invokers = ArrayWrapper<Invoker<UIControl>>()
            dicWrapper!.dic[events.rawValue] = invokers
            return invokers
        }()
        return invokers
    }
    
    public func add<T: UIControl>(_ events: UIControlEvents? = nil, _ closure: @escaping (T) -> Void) {
        assert(nil != (self as? T), "self must be kind of T")
        let events: UIControlEvents! = events ?? {
            switch self {
            case is UIButton: return .touchUpInside
            case is UISwitch: fallthrough
            case is UISlider: return .valueChanged
            case is UITextField: return .editingChanged
            default: return nil
            }
        }()
        assert(nil != events, "no default events for T")
        
        let box = invokers(forEvents: events)
        let invoker = Invoker<UIControl>(self) { sender in
            closure(sender as! T)
        }
        box!.array.append(invoker)
        self.addTarget(invoker, action: #selector(Invoker.invoke), for: events)
    }

    public func remove(_ events: UIControlEvents) {
        guard let box = invokers(forEvents: events, createIfNotExist: false) else {
            return
        }
        for invoker in box.array {
            self.removeTarget(invoker, action: #selector(Invoker.invoke), for: events)
        }
        box.array.removeAll()
    }
    
    public func didAdd(_ events: UIControlEvents) -> Bool {
        guard let box = invokers(forEvents: events, createIfNotExist: false) else {
            return false
        }
        return box.array.count > 0
    }
}
