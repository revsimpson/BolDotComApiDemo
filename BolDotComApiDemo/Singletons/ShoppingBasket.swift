//
//  ShoppingBasket.swift
//  BolDotComAssesmment
//
//  Created by Richard Simpson on 04/11/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import Foundation

// COMMENT: Voor de dummy shopping basket maak ik een singleton zodat deze bij kan houden hoe items er in de basket zitten als men van pagina heen en weer gaat. Daar dit puur ter dummy is sla ik verder nergens iets op over het product. Ik zou natuurlijk ook een array van producten bij kunnen houden ipv de numberOfItems.

class ShoppingBasket {
    
    static let shared = ShoppingBasket()
    
    private var numberOfItems = 0
    
    func addItem() {
        numberOfItems += 1
    }
    
    func getNumberOfItems()-> Int {
        return numberOfItems
    }
    
    func resetBasket() {
        numberOfItems = 0
    }
    
}
