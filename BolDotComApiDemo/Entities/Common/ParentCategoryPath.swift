//
//  ParentCategoryPath.swift
//  BolDotComAssesmment
//
//  Created by Richard Simpson on 01/11/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import Foundation

struct ParentCategoryPath: Codable {
    
    let parentCategories: [ParentCategory]
    
}

struct ParentCategory: Codable {
    
    let id, name: String
    
}
