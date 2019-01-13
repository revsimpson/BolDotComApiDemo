//
//  ProductItem.swift
//  BolDotComAssesmment
//
//  Created by Richard Simpson on 31/10/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import Foundation

struct ProductItem: Codable {
    
    let products: [ProductDetail]?
    
}

struct ProductDetail: Codable {
    
    let id, ean, gpc, title: String
    let specsTag: String?
    let rating: Int
    let shortDescription, longDescription: String?
    let attributeGroups: [AttributeGroup]
    let entityGroups: [EntityGroup]
    let urls: [URLS]
    let images : [Image]?
    let media: [Image]?
    let offerData: OfferData
    let parentCategoryPaths: [ParentCategoryPath]
    
}

struct AttributeGroup: Codable {
    
    let title: String
    let attributes: [Attribute]?
    
}

struct Attribute: Codable {
    
    let label, value: String
    let key: String?
    
}

struct EntityGroup: Codable {
    
    let title: String
    let entities: [Entity]?
    
}

struct Entity: Codable {
    
    let id, value: String
    
}




