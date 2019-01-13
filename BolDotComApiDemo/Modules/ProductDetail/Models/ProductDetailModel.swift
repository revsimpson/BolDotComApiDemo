//
//  ProductDetailModel.swift
//  BolDotComAssesmment
//
//  Created by Richard Simpson on 05/11/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import Foundation

struct ProductDetailModel {
    
    let productId : String
    let titel : String
    let price : String
    let availability : String
    let description : String
    let images : [String]?
    let attributes : [Attribute]?
    let rating: Int?
    
}
