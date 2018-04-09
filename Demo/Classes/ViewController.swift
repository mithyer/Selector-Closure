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
        
        // MARK: UITextField
        
        let field = UITextField.init(frame: CGRect.init(x: 0, y: 50, width: 30, height: 30))
        field.backgroundColor = .yellow
        self.view.addSubview(field)
        _ = field.sce.add { field in
            if let text = field.text {
                print(text)
            }
        }
        
        // MARK: UIGestureRecognizer
        
        _ = self.view.sce.whenTapped {
            print($0)
        }
        
        
        // MARK: UIBarButtonItem
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.sce_init(title: "test", style: .plain) {
            print($0)
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

