//
//  SearchResult.swift
//  BolDotComAssesmment
//
//  Created by Richard Simpson on 02/11/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import Foundation

// COMMENT: Aangezien de tekstsearch van Bol.com nameless is moet er een unkeyedContainer worden geamaakt.
// COMMENT: Ik gebruik dan alleen de eerste twee resultaten omdat voor dit assessment niet meer nodig is.

struct SearchResult: Codable {
    
    let lookupText: String
    let resultArray: [String]
    
    init(from decoder: Decoder) throws {
        
        var container = try decoder.unkeyedContainer()
        lookupText = try container.decode(String.self)
        resultArray = try container.decode([String].self)
        
    }
}
