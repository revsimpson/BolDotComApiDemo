//
//  AlertHelper.swift
//  BolDotComAssesmment
//
//  Created by Richard Simpson on 07/11/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import Foundation
import UIKit

func alertMessage(titel: String, message : String, buttonText: String = "Ok") {
    
    let alertController = UIAlertController(title: titel, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: buttonText, style: .default) { (action:UIAlertAction!) in
    }
    
    alertController.addAction(action)
    
    UIApplication.shared.keyWindow?.rootViewController!.present(alertController, animated: true, completion:nil)
    
}
