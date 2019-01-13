//
//  ProductSearchResultCellModel.swift
//  BolDotComAssesmment
//
//  Created by Richard Simpson on 02/11/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import Foundation

// COMMENT: ProductSearchResultCellModel is het model van de cell wat qua data wordt getoond op scherm. Door deze uit te breiden en in de presenter te koppelen met de reponse van de interactor gebruikt met alleen data die echt nodig is in de cell.

struct ProductSearchResultCellModel {
    
    let productId : String
    let title : String
    let subtitle : String
    let price: String
    let availability : String
    let imageUrl : String
    
}
