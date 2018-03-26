//
//  UIControl+Closures.swift
//  UIKit.Closures
//
//  Created by ray on 2017/12/19.
//  Copyright © 2017年 ray. All rights reserved.
//

import UIKit

fileprivate class Invoker: ClosureWrapper<UIControl> {
    weak var control: UIControl!
    
    convenience init(_ control: UIControl, _ closure: @escaping (UIControl) -> Void) {
        self.init(closure)
        self.control = control
    }
    
    @objc func invoke() {
        closure(control)
    }
}

fileprivate typealias InvokersDicWrapper = DicWrapper<UInt, ArrayWrapper<Invoker>>

fileprivate var invokersDicWrapperKey: UInt = 0

extension UIControl: Attachable {

    fileprivate func invokers(forEvents events: UIControlEvents, createIfNotExist: Bool = true) -> ArrayWrapper<Invoker>? {
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
        let invokers: ArrayWrapper<Invoker>? = dicWrapper!.dic[events.rawValue] ?? {
            if !createIfNotExist {
                return nil
            }
            let invokers = ArrayWrapper<Invoker>()
            dicWrapper!.dic[events.rawValue] = invokers
            return invokers
        }()
        return invokers
    }
    
    public func add<T: UIControl>(_ events: UIControlEvents? = nil, _ closure: @escaping (T) -> Void) {
        assert(nil != (self as? T), "self must be kind of T")
        let events: UIControlEvents = events ?? {
            switch self {
            case is UIButton: return .touchUpInside
            case is UISwitch: fallthrough
            case is UISlider: return .valueChanged
            default: return .allEvents
            }
        }()
        let box = invokers(forEvents: events)
        let invoker = Invoker(self) { control in
            closure(control as! T)
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
