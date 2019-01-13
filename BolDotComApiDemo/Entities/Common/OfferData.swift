//
//  OfferData.swift
//  BolDotComAssesmment
//
//  Created by Richard Simpson on 01/11/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import Foundation

struct OfferData: Codable {
    
    let bolCOM, nonProfessionalSellers, professionalSellers: Int?
    let offers: [Offer]?
    
    enum CodingKeys: String, CodingKey {
        case bolCOM = "bolCom"
        case nonProfessionalSellers, professionalSellers, offers
    }
    
}

struct Offer: Codable {
    let id: String
    let condition: String
    let price: Double
    let availabilityCode: String
    let availabilityDescription, comment: String
    let seller: Seller
    let bestOffer: Bool
    let releaseDate: String?
}

 

