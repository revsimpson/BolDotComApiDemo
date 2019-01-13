//
//  URLS.swift
//  BolDotComAssesmment
//
//  Created by Richard Simpson on 01/11/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import Foundation

struct URLS: Codable {
    
    let key: URLKey
    let value: String
    
}

enum URLKey: String, Codable {
    
    case desktop = "DESKTOP"
    case mobile = "MOBILE"
    
}
