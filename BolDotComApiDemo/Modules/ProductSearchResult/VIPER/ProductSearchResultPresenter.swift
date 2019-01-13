//
//  ProductSearchResultPresenter.swift
//  BolDotComAssesmment
//
//  Created by Richard Simpson on 02/11/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import Foundation

class ProductSearchResultPresenter {
    private let interactor : ProductSearchResultInteractorProtocol
    private let view : ProductSearchResultViewProtocol
    private let searchText : String
    
    var modelArray = [ProductSearchResultCellModel]()
    
    init(interactor:ProductSearchResultInteractorProtocol, view:ProductSearchResultViewProtocol, searchText:String) {
        
        self.interactor = interactor
        self.view = view
        self.searchText = searchText
        
    }
    
    func _dataLoadedSuccesfull() {
        
        view.ShowView()
        view.ReloadData()
        
    }
    
    func _getData() {
        interactor.getCatalog(searchText: searchText) { response in
            
            if let response = response {
                response.products!.forEach({
                    self.modelArray.append(ProductSearchResultCellModel(
                        
                        // COMMENT: ProductSearchResultCellModel wordt gevuld.  Nadat dit gelukt is wordt _dataLoadedSuccesfull aangeroepen die aan de view doorgeeft dat er data beschikbaar is , door de tableview te reloaden.
                        // COMMENT: Als er geen imageUrl is wordt "" terugegeven. Dit zorgt ervoor dat er dan een dummy plaatje komt te staan voor een artikel die al vaststaat in het Storyboard.
                        
                        productId: $0.id,
                        title: $0.title,
                        subtitle: $0.subtitle ?? "",
                        price: String(format: " €%.02f",  $0.offerData.offers![0].price),
                        availability: $0.offerData.offers![0].availabilityDescription,
                        imageUrl: ($0.images?.filter({ (typeImage) -> Bool in
                            typeImage.key ==  "S"
                        }).first?.url) ?? ""  ))
                    
                })
                self._dataLoadedSuccesfull()
            } else {
                
                // Fout bij ophalen data
                self.view.HideView()
                self.view.ShowErrorMessage()
                
            }
        }
    }
}

// MARK: ProductSearchResultPresenterProtocol
extension ProductSearchResultPresenter : ProductSearchResultPresenterProtocol {
    
    func viewDidLoad() {
        
        _getData()
        
    }
    
    func getNumberOfItemInRow()->Int {
        
        return modelArray.count
        
    }
    
    func getCellData()-> [ProductSearchResultCellModel] {
        
        return modelArray
        
    }
    
    func getCellType()-> String {
        
        return ProductSearchResultCellType.ProducSearchResultCell.rawValue
        
    }
}

// MARK: Helpers
enum ProductSearchResultCellType : String {
    
    case ProducSearchResultCell
    
}


