//
//  CommonStructs.swift
//  BolDotComAssesmment
//
//  Created by Richard Simpson on 01/11/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import Foundation

struct Seller: Codable {
    
    let id: String
    let sellerType: String
    let displayName: String
    let url: String?
    let topSeller, useWarrantyRepairConditions: Bool
    let sellerRating: SellerRating?
    let recentReviewCounts: RecentReviewCounts?
    let sellerInformation, approvalPercentage, registrationDate, logo: String?
    
}

struct RecentReviewCounts: Codable {
    
    let positiveReviewCount, neutralReviewCount, negativeReviewCount, totalReviewCount: Int
    
}


struct SellerRating: Codable {
    
    let ratingMethod, sellerRating, productInformationRating, deliveryTimeRating: String
    let shippingRating, serviceRating: String
    
}
