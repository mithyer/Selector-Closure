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
        _ = btn.sce.add {
            $0.setTitle("has tapped", for: .normal)
            $0.sizeToFit()
        }
        let invoker = btn.sce.add { sender in
            print("another one")
        }
        btn.sce.remove(invoker) // "another one" never print
        
        // MARK: UITextField
        
        let field = UITextField.init(frame: CGRect.init(x: 0, y: 50, width: 100, height: 30))
        field.backgroundColor = .yellow
        self.view.addSubview(field)
        _ = field.sce.add { field in
            if let text = field.text {
                print(text)
            }
        }
                
        // MARK: UIBarButtonItem
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.SCE.initialize(title: "test", style: .plain) {
            print("rightBarButtonItem--->\($0)")
        }
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.SCE.initialize(title: "left", style: .plain, { item in
            print("leftBarButtonItem--->\(item)")
        })
        
        // MARK: GestureRecognizer
        
        let view = UIView.init(frame: CGRect.init(x: 0, y: 100, width: 50, height: 50))
        view.backgroundColor = .green
        view.isUserInteractionEnabled = true
        self.view.addSubview(view)
        let tgr = UITapGestureRecognizer.SCE.initialize {
            print("tap--->\($0)")
        }
        view.addGestureRecognizer(tgr)
        
        // MARK: WhenTapped
        _ = self.view.sce.whenTapped { (tgr) in
            print(tgr)
        }
    
    }
    
}


class ViewController: UINavigationController {


    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.viewControllers = [RootViewController()]
        self.navigationBar.isTranslucent = false
    }
}

