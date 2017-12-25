//
//  ViewController.swift
//  UIKit.Closures.Demo
//
//  Created by ray on 2017/12/22.
//  Copyright © 2017年 ray. All rights reserved.
//

import UIKit



class RootViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: UIButton
        
        let btn = UIButton(type: .roundedRect)
        btn.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        btn.setTitle("btn", for: .normal)
        btn.backgroundColor = .red
        self.view.addSubview(btn)
        btn.add(.touchUpInside) {
            print($0!)
        }
        btn.add(.touchUpInside) {
            print($0!)
        }
        
        
        // MARK: UIGestureRecognizer
        
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(UITapGestureRecognizer {
            print($0)
        })
        
        
        // MARK: UIBarButtonItem
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "test", style: .plain, {
            print($0!)
        })
    }
    
}


class ViewController: UINavigationController {


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.viewControllers = [RootViewController()]
        self.navigationBar.isTranslucent = false
    }
}

