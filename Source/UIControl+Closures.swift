//
//  UIControl+Closures.swift
//  UIKit.Closures
//
//  Created by ray on 2017/12/19.
//  Copyright © 2017年 ray. All rights reserved.
//

import UIKit


extension UIControlEvents: Hashable {
    public var hashValue: Int {
        return self.rawValue.hashValue
    }
}

typealias InvokersDicWrapper<T: UIControl> = DicWrapper<UIControlEvents, ArrayWrapper<Invoker<T>>>

fileprivate var invokersDicWrapperKey: UInt = 0

extension UIControl: Attachable {

    fileprivate func invokers<T: UIControl>(forEvents events: UIControlEvents, createIfNotExist: Bool = true) -> ArrayWrapper<Invoker<T>>? {
        let dicWrapper: InvokersDicWrapper<T>? = self.getAttach(forKey: &invokersDicWrapperKey) as? InvokersDicWrapper<T> ?? {
            if !createIfNotExist {
                return nil
            }
            let wrapper = InvokersDicWrapper<T>()
            self.set(wrapper, forKey: &invokersDicWrapperKey)
            return wrapper
        }()
        if nil == dicWrapper {
            return nil
        }
        let invokers: ArrayWrapper<Invoker<T>>? = dicWrapper!.dic[events] ?? {
            if !createIfNotExist {
                return nil
            }
            let invokers = ArrayWrapper<Invoker<T>>()
            dicWrapper!.dic[events] = invokers
            return invokers
        }()
        return invokers
    }
    
    public func add<T: UIControl>(_ events: UIControlEvents? = nil, _ closure: @escaping (T) -> Void) -> Invoker<T> {
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
        
        let wrapper: ArrayWrapper<Invoker<T>> = invokers(forEvents: events)!
        let invoker = Invoker(self as! T, closure)
        invoker.events = events
        wrapper.array.append(invoker)
        self.addTarget(invoker, action: invoker.action, for: events)
        return invoker
    }

    public func remove<T: UIControl>(_ invoker: Invoker<T>) {
        guard let dicWrapper = self.getAttach(forKey: &invokersDicWrapperKey) as? InvokersDicWrapper,
            let events = invoker.events,
            let arrayWrapper = dicWrapper.dic[events] else {
            return
        }
        for (idx, ivk) in arrayWrapper.array.enumerated() {
            if ivk === invoker {
                self.removeTarget(invoker, action: invoker.action, for: events)
                arrayWrapper.array.remove(at: idx)
                break
            }
        }
    }
    
    public func removeAll(for events: UIControlEvents) {
        guard let wrapper = invokers(forEvents: events, createIfNotExist: false) else {
            return
        }
        for invoker in wrapper.array {
            self.removeTarget(invoker, action: invoker.action, for: events)
        }
        wrapper.array.removeAll()
    }
    
    public func didAdd(_ events: UIControlEvents) -> Bool {
        guard let wrapper = invokers(forEvents: events, createIfNotExist: false) else {
            return false
        }
        return wrapper.array.count > 0
    }
}
