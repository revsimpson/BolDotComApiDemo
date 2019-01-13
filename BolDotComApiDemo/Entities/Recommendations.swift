//
//  Recommendations.swift
//  BolDotComAssesmment
//
//  Created by Richard Simpson on 01/11/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import Foundation

struct Recommendations: Codable {
    let products: [ProductRecommendation]?
}

struct ProductRecommendation: Codable {
    
    let id, ean: String
    let gpc: String
    let title: String
    let specsTag: String?
    let rating: Int
    let shortDescription, longDescription: String?
    let urls: [URLS]?
    let images, media: [Image]?
    let offerData: OfferData?
    let parentCategoryPaths: [ParentCategoryPath]?
    let trackLists: [TrackList]?
    let subtitle: String?
    
}

struct RecommendationOffer: Codable {
    
    let id, condition: String
    let price: Double
    let availabilityCode, availabilityDescription, comment: String
    let seller: Seller?
    let bestOffer: Bool
    let releaseDate: String?
    let listPrice: Double?
    
}


struct TrackList: Codable {
    
    let discNumber: Int
    let track: [Track]
    
}

struct Track: Codable {
    
    let title: String
    let trackNumber: Int
    
}



 
