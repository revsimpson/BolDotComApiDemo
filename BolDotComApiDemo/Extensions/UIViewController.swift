//
//  UIViewController.swift
//  BolDotComAssesmment
//
//  Created by Richard Simpson on 02/11/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import Foundation
import UIKit

 // COMMENT: Om te zorgen dat op elke pagina dezelfde header komt is er een  extension op UIViewController gemaakt die na de ViewDidLoad opgeroepen kan worden.

extension UIViewController {
    
    func setBolLogo() {
        let logo = UIImage(named: "bolCom")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
        let navigationBar = navigationController?.navigationBar
        navigationBar?.barTintColor = .white
        navigationBar?.isTranslucent = false
    }
    
}
