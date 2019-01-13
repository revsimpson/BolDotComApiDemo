//
//  DomainSettings.swift
//  BolDotComAssesmment
//
//  Created by Richard Simpson on 03/11/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import Foundation
enum ServerPaths: String {
    case TextSuggesties
    case ProductSearchResults
    case ProductDetail
    case RelatedProducts
    case RecommendationProducts
    
    func getpath() -> String {
        
        switch self {
        case .TextSuggesties :
            return SERVERPATH_TEXTSUGGESTIES
        case .ProductSearchResults :
            return SERVERPATH_PRODUCT_SEARCHRESULT
        case .ProductDetail :
            return SERVERPATH_PRODUCT_DETAIL
        case .RelatedProducts :
            return SERVERPATH_RELATED_PRODUCTS
        case .RecommendationProducts :
            return SERVERPATH_PATH_RECOMMENDATION_PRODUCTS
        }
        
    }
}


// COMMENT: Opsplitsen van alle waarden die nodig zijn voor servicecalls.

// MARK: Common

fileprivate let SERVER_KEY = "D55EFE39C4EB4E04A50A65D2932C6127"
fileprivate let SERVERCALL_TYPE = "https://"
fileprivate let DOMAIN_API_BOL_COM = "api.bol.com"
fileprivate let GET_FORMAT = "&format=json"


// MARK:Textsearch suggesties
fileprivate let DOMAIN_BOL_COM_SUGGESTIES = "zoeksuggesties.s-bol.com"
fileprivate let PATH_SUGGESTIES  = "/extern/qs/OpenSearch/media_all/"
fileprivate let SERVERPATH_TEXTSUGGESTIES = SERVERCALL_TYPE +
                                                        DOMAIN_BOL_COM_SUGGESTIES +
                                                        PATH_SUGGESTIES

// MARK: Product Searchresult
fileprivate let PATH_PRODUCT_SEARCHRESULT =  "/catalog/v4/search/?apikey="
fileprivate let PATH_QUERY_PRODUCT_SEARCHRESULT = "&q=%@"
fileprivate let SERVERPATH_PRODUCT_SEARCHRESULT = SERVERCALL_TYPE +
                                                                    DOMAIN_API_BOL_COM +
                                                                    PATH_PRODUCT_SEARCHRESULT +
                                                                    SERVER_KEY +
                                                                    PATH_QUERY_PRODUCT_SEARCHRESULT +
                                                                    GET_FORMAT

// MARK: Product Detail
fileprivate let PATH_PRODUCT_DETAIL = "/catalog/v4/products/"
fileprivate let PATH_SEARCH_WITH_KEY_PRODUCT_DETAIL = "%@/?apikey="
fileprivate let SERVERPATH_PRODUCT_DETAIL = SERVERCALL_TYPE +
                                                        DOMAIN_API_BOL_COM +
                                                        PATH_PRODUCT_DETAIL +
                                                        PATH_SEARCH_WITH_KEY_PRODUCT_DETAIL +
                                                        SERVER_KEY +
                                                        GET_FORMAT

// MARK: Related Products
fileprivate let PATH_RELATED_PRODUCTS = "/catalog/v4/relatedproducts/"
fileprivate let PATH_SEARCH_WITH_KEY_RELATED_PRODUCTS = "%@/?apikey="
fileprivate let SERVERPATH_RELATED_PRODUCTS = SERVERCALL_TYPE +
                                                            DOMAIN_API_BOL_COM +
                                                            PATH_RELATED_PRODUCTS +
                                                            PATH_SEARCH_WITH_KEY_RELATED_PRODUCTS  +
                                                            SERVER_KEY + 
                                                            GET_FORMAT 

// MARK: Recommendation Products
fileprivate let PATH_RECOMMENDATION_PRODUCTS = "/catalog/v4/recommendations/"
fileprivate let PATH_SEARCH_WITH_KEYPATH_RECOMMENDATION_PRODUCTS = "%@/?apikey="
fileprivate let SERVERPATH_PATH_RECOMMENDATION_PRODUCTS = SERVERCALL_TYPE +
    DOMAIN_API_BOL_COM +
    PATH_RECOMMENDATION_PRODUCTS +
    PATH_SEARCH_WITH_KEYPATH_RECOMMENDATION_PRODUCTS  +
    SERVER_KEY +
    GET_FORMAT



