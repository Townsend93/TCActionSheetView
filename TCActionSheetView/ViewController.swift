//
//  ViewController.swift
//  TCActionSheetView
//
//  Created by tancheng on 2018/7/17.
//  Copyright © 2018年 tancheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TCActionSheetViewDelegate {
    func actionSelected(index: Int) {
        print("\(index)")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func show(_ sender: Any) {
        
        let sheet = TCActionSheetView.init(actions: ["拍照","从相册中选择"], delegate: self)
        
        sheet.show()
    
    }
    
}

