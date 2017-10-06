//
//  ViewController.swift
//  Touch_ID
//
//  Created by Abdullah Alhassan on 10/6/17.
//  Copyright © 2017 Abdullah Alhassan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let touchId = TouchIDAuthentication()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        touchId.authenticateUser(with: 1) { (error) in
            if let _ = error {
                self.view.backgroundColor = .red
            } else {
                self.view.backgroundColor = .green
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

