//
//  ProductSearchResultInteractor.swift
//  BolDotComAssesmment
//
//  Created by Richard Simpson on 02/11/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import Foundation

// De interactor haalt de data op en geeft deze terug aan de presenter als de data binnen is gekomen. Dit gebeurd door middel van een completionblock.

class ProductSearchResultInteractor {}

extension ProductSearchResultInteractor : ProductSearchResultInteractorProtocol {
    
    func getCatalog(searchText:String, completion: @escaping(Catalog?)->Void)  {
        let searchUrl = String(format: ServerPaths.ProductSearchResults.getpath() , searchText).addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        guard let catalogUrl =  URL(string:searchUrl!) else { return }
        
        URLSession.shared.dataTask(with: catalogUrl) { (data, response
            , error) in
    
            guard let data = data else { return }
            do {
                
                let decoder = JSONDecoder()
                let catalogData = try decoder.decode(Catalog.self, from: data)
                completion(catalogData)
                
            } catch {
                
                completion(nil)

            }
            }.resume()
    }
}
