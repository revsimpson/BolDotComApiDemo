//
//  GerelateerdeProductenCell.swift
//  BolDotComAssesmment
//
//  Created by Richard Simpson on 04/11/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import UIKit
import Foundation

class GerelateerdeProductenCell: UITableViewCell, ProductDetailBaseCellProtocol {
    
    @IBOutlet var collectioView: UICollectionView! 
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
    }
    
    func setData(data: Any) {
    }
}


//  COMMENT: Zorgt voor de verbinding met de collectionview in de cell met de viewcontroller die deze functie aanroept.
extension GerelateerdeProductenCell {
    
    func setCollectionViewDataSourceDelegate <D: UICollectionViewDataSource & UICollectionViewDelegate> (dataSourceDelegate: D, forRow row: Int) {
        
        collectioView.delegate = dataSourceDelegate
        collectioView.dataSource = dataSourceDelegate
        collectioView.tag = row
        collectioView.reloadData()
        
    }
}
