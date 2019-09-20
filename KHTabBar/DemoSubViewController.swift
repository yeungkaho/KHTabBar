//
//  DemoSubViewController.swift
//  KHTabBar
//
//  Created by kaho on 20/09/2019.
//  Copyright © 2019 kaho. All rights reserved.
//

import UIKit

class DemoSubViewController: UIViewController {

    
    @IBOutlet weak var tv: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        log("viewDidLoad")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        log("viewWillAppear: \(animated)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        log("viewDidAppear: \(animated)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        log("viewWillDisappear: \(animated)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        log("viewDidDisappear: \(animated)")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        log("viewWillLayoutSubviews")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        log("viewDidLayoutSubviews")
    }
    
    func log(_ text:String) {
        tv.text += text + "\n"
    }
}
