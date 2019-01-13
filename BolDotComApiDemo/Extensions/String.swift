//
//  String.swift
//  BolDotComAssesmment
//
//  Created by Richard Simpson on 03/11/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import Foundation
import UIKit

// Wordt gebruikt bij de extension van UIView 
extension String {
    
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
}
