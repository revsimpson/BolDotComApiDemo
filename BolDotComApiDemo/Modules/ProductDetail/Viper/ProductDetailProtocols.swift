//
//  ProductDetailProtocols.swift
//  BolDotComAssesmment
//
//  Created by Richard Simpson on 03/11/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import Foundation

protocol ProductDetailInteractorProtocol {
    
    func getItem<T:Codable>(productID:String, serverPath:String, completion: @escaping (T?)->Void)
}

protocol ProductDetailPresenterProtocol {
    
    func viewDidLoad()
    func getNumberOfItemInRow()->Int
    func getCellType() -> [String]
    func getCellData(row:Int) ->  (celltype:ProductDetailCellType, data:Any)
    func getRelatedProducts()-> [StrippedProductDetailModel]
    func isDataLoaded()->Bool
    func loadRecommendationProductWith(id:String)
    
}

protocol ProductDetailViewProtocol : BaseViewProtocol { }

protocol ProductDetailBaseCellProtocol {
    
    func setData(data:Any)
    
}

protocol RecommendationCellProtocol: ProductDetailBaseCellProtocol {
    func setDelegate(delegate: RecommendationProtocol)
}
