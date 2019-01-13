//
//  ReadTextViewController.swift
//  BolDotComAssesmment
//
//  Created by Richard Simpson on 05/11/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import UIKit

class ReadTextViewController: UIViewController {
    
    var textForTextView = ""
    @IBOutlet var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setBolLogo()
        textView.text = textForTextView
        
    }
    
}
