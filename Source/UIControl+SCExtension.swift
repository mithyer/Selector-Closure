//
//  UIControl+Closures.swift
//  UIKit.Closures
//
//  Created by ray on 2017/12/19.
//  Copyright © 2017年 ray. All rights reserved.
//

import UIKit


extension UIControl.Event: Hashable {
    
    public var hashValue: Int {
        return self.rawValue.hashValue
    }
}

class DicWrapper<K: Hashable, V> {
    
    var dic = [K: V]()
}

class ArrayWrapper<T> {
    
    var array = [T]()
}

fileprivate typealias InvokersDicWrapper<T: UIControl> = DicWrapper<UIControl.Event, ArrayWrapper<Invoker<T>>>

fileprivate var invokersDicWrapperKey: Void?


extension SCECls where T: UIControl {
    
    func invokers(forEvents events: UIControl.Event, createIfNotExist: Bool = true) -> ArrayWrapper<Invoker<T>>? {
        let dicWrapper: InvokersDicWrapper<T>? = self.getAttach(forKey: &invokersDicWrapperKey) ?? {
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
    
    @discardableResult
    public func add(_ events: UIControl.Event? = nil, _ closure: @escaping (T) -> Void) -> Invoker<T> {
        let control = self.object!
        let events: UIControl.Event! = events ?? {
            switch control {
                case is UIButton: return .touchUpInside
                case is UISwitch: fallthrough
                case is UISlider: return .valueChanged
                case is UITextField: return .editingChanged
                default: return nil
            }
        }()
        assert(nil != events, "no default events for T")
        
        let wrapper: ArrayWrapper<Invoker<T>> = invokers(forEvents: events)!
        let invoker = Invoker(control, closure)
        invoker.events = events
        wrapper.array.append(invoker)
        control.addTarget(invoker, action: invoker.action, for: events)
        return invoker
    }
    
    public func remove(_ invoker: Invoker<T>) {
        guard let control = self.object,
            let dicWrapper: InvokersDicWrapper<T> = self.getAttach(forKey: &invokersDicWrapperKey),
            let events = invoker.events,
            let arrayWrapper = dicWrapper.dic[events] else {
                return
        }
        for (idx, ivk) in arrayWrapper.array.enumerated() {
            if ivk === invoker {
                control.removeTarget(invoker, action: invoker.action, for: events)
                arrayWrapper.array.remove(at: idx)
                break
            }
        }
    }
    
    public func removeAll(for events: UIControl.Event) {
        let control = self.object!
        guard let wrapper = invokers(forEvents: events, createIfNotExist: false) else {
            return
        }
        for invoker in wrapper.array {
            control.removeTarget(invoker, action: invoker.action, for: events)
        }
        wrapper.array.removeAll()
    }
    
    public func didAdd(_ events: UIControl.Event) -> Bool {
        guard let wrapper = invokers(forEvents: events, createIfNotExist: false) else {
            return false
        }
        return wrapper.array.count > 0
    }
}

