//
//  Catalog.swift
//  BolDotComAssesmment
//
//  Created by Richard Simpson on 31/10/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import Foundation
import UIKit

struct Catalog: Codable {
    let originalRequest: OriginalRequest
    let totalResultSize: Int
    let products: [Product]?
}

struct OriginalRequest: Codable {
    
    let category: Category
    
}

struct Category: Codable {
}

struct Product: Codable {
    
    let id, ean, gpc, title: String
    let subtitle: String?
    let specsTag, summary: String?
    let rating: Int
    let shortDescription, longDescription: String?
    let urls: [URLS]
    let images, media: [Image]?
    let offerData: OfferData
    let parentCategoryPaths: [ParentCategoryPath]
    
}








 
