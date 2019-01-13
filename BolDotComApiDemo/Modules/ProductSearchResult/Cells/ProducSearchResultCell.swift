//
//  ProducSearchResultCell.swift
//  BolDotComAssesmment
//
//  Created by Richard Simpson on 02/11/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import UIKit

class ProducSearchResultCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitlelLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var availabilityLabel: UILabel!
    @IBOutlet var productImage: UIImageView!
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
    }
    
    func setData(data:ProductSearchResultCellModel) {
        
        titleLabel.text = data.title
        subtitlelLabel.text = data.subtitle
        priceLabel.text = data.price
        availabilityLabel.text = data.availability
        
        // COMMENT:  Als er geen plaatje is moet de originele blijven staan en dat is in dit geval de Billie van Bol.com
        if data.imageUrl != "" {
            productImage.loadImageFrom(urlString: data.imageUrl)
        }
        
    }
    
}
