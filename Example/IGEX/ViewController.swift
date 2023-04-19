//
//  ViewController.swift
//  IGEX
//
//  Created by 95286760 on 04/19/2023.
//  Copyright (c) 2023 95286760. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onClick(_ sender: Any) {
        let vc = IGController.create()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}

