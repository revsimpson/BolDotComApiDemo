//
//  ProductSearchResultProtocols.swift
//  BolDotComAssesmment
//
//  Created by Richard Simpson on 02/11/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import Foundation

protocol ProductSearchResultInteractorProtocol {
    
    func getCatalog(searchText:String, completion: @escaping(Catalog?)->Void)
    
}

protocol ProductSearchResultPresenterProtocol {
    
    func viewDidLoad()
    func getNumberOfItemInRow()->Int
    func getCellData()-> [ProductSearchResultCellModel]
    func getCellType()-> String
    
}

protocol ProductSearchResultViewProtocol : BaseViewProtocol {}

