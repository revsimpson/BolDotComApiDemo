//
//  ProductDetailInteractor.swift
//  BolDotComAssesmment
//
//  Created by Richard Simpson on 03/11/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//


import Foundation

class ProductDetailInteractor  { }

extension ProductDetailInteractor : ProductDetailInteractorProtocol {
    
    func getItem<T:Codable>(productID:String, serverPath:String, completion: @escaping (T?)->Void) {
        guard let productItemUrl =  URL(string:String(format: serverPath , productID)) else { return }
        
        URLSession.shared.dataTask(with: productItemUrl) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                
                let decoder = JSONDecoder()
                let productItemData = try decoder.decode(T.self, from: data)
                completion(productItemData)
                
            } catch {
                
                completion(nil)
            }
            }.resume()
        
    }
}
