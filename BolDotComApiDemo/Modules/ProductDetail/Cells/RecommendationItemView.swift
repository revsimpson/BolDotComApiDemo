//
//  RecommendationItemView.swift
//  BolDotComAssesmment
//
//  Created by Richard Simpson on 06/11/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import UIKit

class RecommendationItemView: UIView {

    @IBOutlet var itemImage: UIImageView!
    @IBOutlet var itemTitle: UILabel!
    @IBOutlet var itemPrice: UILabel!
    
    var delegate : RecommendationProtocol!
    var id : String!
    
    func setData(data:Any, delegate : RecommendationProtocol){
        self.delegate = delegate
        
        let recommendationTabGesture =  UITapGestureRecognizer(target: self, action: #selector(_imageTapped))
        itemImage.addGestureRecognizer(recommendationTabGesture)
        
        let item = data as! StrippedProductDetailModel
        itemImage.loadImageFrom(urlString: item.image)
        itemTitle.text = item.title
        itemPrice.text = item.price
        id = item.id
        
    }
    
    @objc private func _imageTapped() {
        self.delegate.getProductWith(id: id)
    }
 
}
