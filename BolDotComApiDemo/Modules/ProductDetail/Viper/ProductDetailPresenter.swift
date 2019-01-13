//
//  ProductDetailPresenter.swift
//  BolDotComAssesmment
//
//  Created by Richard Simpson on 03/11/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import Foundation

// MARK: Helpers
enum ProductDetailCellType : String, CaseIterable {
    
    case ProductDetailCell
    case RecommendationCell
    case GerelateerdeProductenCell
    
}
class ProductDetailPresenter {
    
    private let interactor : ProductDetailInteractorProtocol
    private let view : ProductDetailViewProtocol
    private let productId : String
    private var tableDataSet = [(celltype:ProductDetailCellType, data:Any)]()
    
    // Data Holders
    var productDetailModel : ProductDetailModel!
    var productAccesoriesItems :  [StrippedProductDetailModel]!
    var recommendationItems : [StrippedProductDetailModel]!
    
    // Data Receive Manager
    // COMMENT: De data receive manager is niet echt nodig. Het enige wat het doet is garanderen dat alles wordt getoond en update de tableview maar 1x
    // COMMENT: Als men niet de manager gebruikt dan moet bij _dataLoadedSuccesfull() tableDataset = [] gezet wordenen de if statement van de receiver worden verwijderd.
    // COMMENT: Wanneer dat is gedaan zal de tabel update wat er op dat moment beschikbaar is. Voor het assessment heb ik gekozen voor een datareceiver.
    var dataReceiveManager = (productDetail:false,accessories:false,recommendations:false)
    
    init(interactor:ProductDetailInteractorProtocol, view:ProductDetailViewProtocol, productId:String) {
        self.interactor = interactor
        self.view = view
        self.productId = productId
    }
    
    private func _resetData() {
        view.HideView()
        tableDataSet = []
        productDetailModel =  nil
        productAccesoriesItems =  nil
        recommendationItems = nil
        dataReceiveManager.accessories = false
        dataReceiveManager.productDetail = false
        dataReceiveManager.recommendations = false
    }
    
    func _dataLoadedSuccesfull() {
        
        if dataReceiveManager.productDetail && dataReceiveManager.accessories && dataReceiveManager.recommendations {
            if let _ = productDetailModel {
                tableDataSet.append((celltype: .ProductDetailCell, data:productDetailModel))
            }
            
            if let _ = productAccesoriesItems {
                tableDataSet.append((celltype: .GerelateerdeProductenCell, data:productAccesoriesItems))
            }
            
            if let _ = recommendationItems {
                tableDataSet.append((celltype: .RecommendationCell, data:recommendationItems))
            }
            view.ShowView()
            view.ReloadData()
        }
    }
    
    func _getFilteredMediaImageUrlStrings(media:[Image]?)->[String] {
        
        // Filter zodat alle image die Large zijn overblijven en doe dan een compactmap om de urlstrings in de string array "images" te zetten aangezien meer niet nodig is om te tonen.
        return media?.filter({ (size) -> Bool in size.key == "XL" }).compactMap({  $0.url }) ?? []
        
    }
    
    func _getPrettyEuroFromatedString(pirce:Double)->String {
        
        return String(format: " €%.02f",  pirce)
        
    }
    
    func _getDataWith(id:String = "") {
        
        let pId = id == "" ? productId : id
        
        // COMMENT: Haal de ProductDetail informatie op
        interactor.getItem(productID: pId, serverPath:  ServerPaths.ProductDetail.getpath() , completion: { (productResponse: ProductItem?) in
        
            if let response = productResponse, let data = response.products!.first {
                
                self.productDetailModel = ProductDetailModel(
                    productId: data.id,
                    titel: data.title,
                    price: self._getPrettyEuroFromatedString(pirce: data.offerData.offers?[0].price ?? 0),
                    availability: data.offerData.offers?[0].availabilityDescription ?? "",
                    description: data.shortDescription ?? "",
                    images: self._getFilteredMediaImageUrlStrings(media: data.media),
                    attributes:  data.attributeGroups[0].attributes,
                    rating: data.rating)
                
                // COMMENT: Zet de dataReceiveManager aan voor ProductDetail
                self.dataReceiveManager.productDetail = true
                self._dataLoadedSuccesfull()
            } else {
                
                // COMMENT: We vangen alleen hier de fout af daar dit het hoofditem is wat binnen MOET komen en de rest afhankelijk is van het hoofdproduct. Als het hoofdproduct slaagt en de rest niet is er altijd nog wat te tonen!
                self.view.HideView()
                self.view.ShowErrorMessage()
                
            }
        })
        
        // COMMENT: Haal de related productId's op en maak een call om de gerelateerde producten op te halen. Er komen niet altijd accessories voor !!!
        interactor.getItem(productID: pId, serverPath: ServerPaths.RelatedProducts.getpath(), completion: { (relatedProductResponse : Accessories?) in
            
            if let response = relatedProductResponse,  let accessories = response.accessories  {
                
                var productAccessories = [ProductAccessoriesModel]()
                accessories.forEach({  productAccessories.append(ProductAccessoriesModel(productId: $0.productID))  })
                
                // COMMENT: Nu zijn de accossories binnen en worden de producten opgehaald om te tonen.
                // COMMENT: Ik sla nu alleen de tekst en een afbeelding op die niet klikbaar zullen zijn.
                // COMMENT: De array van de productAccessories wordt nu als String gemapped met een komma scheidingsteken zodat het mee naar de server kan worden gestuurd.
                let allProductIds = productAccessories.map({ $0.productId } ).joined(separator: ",")
                
                // COMMENT Haal de producten op
              self.interactor.getItem(productID: allProductIds, serverPath:  ServerPaths.ProductDetail.getpath() , completion: { (productItemsResponse: ProductItem?) in
                    if let productItems = productItemsResponse {
                        self.productAccesoriesItems = [StrippedProductDetailModel]()
                        productItems.products?.forEach({ self.productAccesoriesItems.append(
                            StrippedProductDetailModel(
                                id:$0.id,
                                title:$0.title ,
                                image: ($0.images?.filter({ (typeImage) -> Bool in
                                    typeImage.key ==  "S"
                                }).first?.url) ?? "",
                                price: self._getPrettyEuroFromatedString(pirce: $0.offerData.offers![0].price)  )
                            )
                        })
                        self.dataReceiveManager.accessories = true
                        self._dataLoadedSuccesfull()
                    }
                })
                
            } else {
                // COMMENT: Er zijn geen accessoires beschikbaar. Geef dit door aan de dataReceiveManager door deze op true te zetten waardoor de rest niet meer hoef te wachten
                self.dataReceiveManager.accessories = true
                self._dataLoadedSuccesfull()
            }
        })
        
        // COMMENT: Haal de recommendatie producten op
        interactor.getItem(productID: pId, serverPath: ServerPaths.RecommendationProducts.getpath(), completion: { (recommendatieResponse: Recommendations?) in
    
            if let recommendatieItems = recommendatieResponse {
                self.recommendationItems = [StrippedProductDetailModel]()
                recommendatieItems.products?.forEach({ self.recommendationItems.append(
                    StrippedProductDetailModel(
                        id:$0.id,
                        title:$0.title ,
                        image: ($0.images?.filter({ (typeImage) -> Bool in
                            typeImage.key ==  "S"
                        }).first?.url) ?? "",
                        price: ""  )
                    )
                    
                })
                self.dataReceiveManager.recommendations = true
                self._dataLoadedSuccesfull()
            }
        })
    }
}

extension ProductDetailPresenter : ProductDetailPresenterProtocol {
    
    func isDataLoaded()->Bool {
        
        return dataReceiveManager.accessories == true && dataReceiveManager.productDetail == true && dataReceiveManager.recommendations == true
        
    }
    
    func viewDidLoad() {
        
        _getDataWith()
        
    }
    
    func loadRecommendationProductWith(id:String) {
        _resetData()
        _getDataWith(id: id)
        
    }
    
    func getRelatedProducts()-> [StrippedProductDetailModel] {
        
        return tableDataSet.filter({ $0.celltype == ProductDetailCellType.GerelateerdeProductenCell }).first!.data as! [StrippedProductDetailModel]
        
    }
    
    func getNumberOfItemInRow() -> Int {
        
        return tableDataSet.count
        
    }
    
    func getCellData(row:Int) ->  (celltype:ProductDetailCellType, data:Any) {
        
        return tableDataSet[row]
        
    }
    
    func getCellType() -> [String] {
        
        return ProductDetailCellType.allCases.compactMap({ $0.rawValue })
        
    }
}

 


