//
//  CollectionViewCell.swift
//  BolDotComAssesmment
//
//  Created by Richard Simpson on 04/11/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet var productImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setData (data:StrippedProductDetailModel) {
        
        productImage.loadImageFrom(urlString: data.image)
        titleLabel.text  = data.title
        priceLabel.text = data.price
        
    }
}
