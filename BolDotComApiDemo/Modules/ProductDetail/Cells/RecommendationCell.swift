//
//  RecommendationCell.swift
//  BolDotComAssesmment
//
//  Created by Richard Simpson on 05/11/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import UIKit

protocol  RecommendationProtocol {
    
    func getProductWith(id:String)
    
}

class RecommendationCell: UITableViewCell {
    
    @IBOutlet var stackView: UIStackView!
    var delegate : RecommendationProtocol!
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
    }

}

extension RecommendationCell : RecommendationCellProtocol {
    func setDelegate(delegate: RecommendationProtocol) {
        self.delegate = delegate
    }
    
    
    func setData(data: Any) {
        
        let items = data as! [StrippedProductDetailModel]
        stackView.removeAllArrangedSubviews()
 
        for item in items {
            var itemView : RecommendationItemView!
            itemView = RecommendationItemView.loadNib()
            itemView.widthAnchor.constraint(equalToConstant: 140.0).isActive = true
             itemView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
            itemView.setData(data: item, delegate: delegate)
            self.stackView.addArrangedSubview(itemView)
        }
        
    }
    
}


