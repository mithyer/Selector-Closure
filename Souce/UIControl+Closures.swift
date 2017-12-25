//
//  UIControl+Closures.swift
//  UIKit.Closures
//
//  Created by ray on 2017/12/19.
//  Copyright © 2017年 ray. All rights reserved.
//

import UIKit

fileprivate class Invoker {
    var closure: (UIControl?) -> Void
    weak var control: UIControl?
    
    init(_ control: UIControl, _ closure: @escaping (UIControl?) -> Void) {
        self.closure = closure
        self.control = control
    }
    
    @objc func invoke() {
        closure(control)
    }
}

fileprivate typealias Dealer = DicBox<UInt, ArrayBox<Invoker>>

fileprivate var dealerKey: UInt = 0

extension UIControl: Attachable {

    fileprivate func invokersForEvents(events: UIControlEvents, createIfNotExist: Bool = true) -> ArrayBox<Invoker>? {
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
        let invokers: ArrayBox<Invoker>? = dealer!.dic[events.rawValue] ?? {
            if !createIfNotExist {
                return nil
            }
            let invokers = ArrayBox<Invoker>()
            dealer!.dic[events.rawValue] = invokers
            return invokers
        }()
        return invokers
    }
    
    public func add(_ events: UIControlEvents, _ closure: @escaping (UIControl?) -> Void) {
        let holder = invokersForEvents(events: events)
        let invoker = Invoker(self, closure)
        holder!.array.append(invoker)
        self.addTarget(invoker, action: #selector(Invoker.invoke), for: events)
    }

    public func remove(_ events: UIControlEvents) {
        guard let holder = invokersForEvents(events: events, createIfNotExist: false) else {
            return
        }
        for invoker in holder.array {
            self.removeTarget(invoker, action: #selector(Invoker.invoke), for: events)
        }
        holder.array.removeAll()
    }
    
    public func didAdd(_ events: UIControlEvents) -> Bool {
        guard let holder = invokersForEvents(events: events, createIfNotExist: false) else {
            return false
        }
        return holder.array.count > 0
    }
}
