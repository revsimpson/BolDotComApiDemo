//
//  Accessories.swift
//  BolDotComAssesmment
//
//  Created by Richard Simpson on 03/11/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import Foundation
struct Accessories: Codable {
    
    let accessories: [Accessory]?
    
}

struct Accessory: Codable {
    
    let productID: String

    enum CodingKeys: String, CodingKey {
        case productID = "productId"
    }
    
}

 
