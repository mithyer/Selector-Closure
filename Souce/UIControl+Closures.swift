//
//  UIControl+Closures.swift
//  UIKit.Closures
//
//  Created by ray on 2017/12/19.
//  Copyright © 2017年 ray. All rights reserved.
//

import UIKit

fileprivate class Invoker: ClosureWrapper<UIControl?> {
    weak var control: UIControl?
    
    convenience init(_ control: UIControl, _ closure: @escaping (UIControl?) -> Void) {
        self.init(closure)
        self.control = control
    }
    
    @objc func invoke() {
        closure(control)
    }
}

fileprivate typealias Dealer = DicWrapper<UInt, ArrayWrapper<Invoker>>

fileprivate var dealerKey: UInt = 0

extension UIControl: Attachable {

    fileprivate func invokers(forEvents events: UIControlEvents, createIfNotExist: Bool = true) -> ArrayWrapper<Invoker>? {
        let dealer: Dealer? = self.getAttach(forKey: &dealerKey) as? Dealer ?? {
            if !createIfNotExist {
                return nil
            }
            let dealer = Dealer()
            self.set(dealer, forKey: &dealerKey)
            return dealer
        }()
        if nil == dealer {
            return nil
        }
        let invokers: ArrayWrapper<Invoker>? = dealer!.dic[events.rawValue] ?? {
            if !createIfNotExist {
                return nil
            }
            let invokers = ArrayWrapper<Invoker>()
            dealer!.dic[events.rawValue] = invokers
            return invokers
        }()
        return invokers
    }
    
    public func add(_ events: UIControlEvents, _ closure: @escaping (UIControl?) -> Void) {
        let box = invokers(forEvents: events)
        let invoker = Invoker(self, closure)
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
