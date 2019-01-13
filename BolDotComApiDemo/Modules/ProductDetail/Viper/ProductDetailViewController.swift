//
//  ProductDetailViewController.swift
//  BolDotComAssesmment
//
//  Created by Richard Simpson on 03/11/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var toolbarView: ToolbarView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var presenter :  ProductDetailPresenterProtocol!
    var productId = ""
    var barView : ToolbarView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        presenter = ProductDetailPresenter(interactor: ProductDetailInteractor(), view: self, productId: productId)
        _configure()
        presenter.viewDidLoad()
        
    }
    
    private func _configure(){
        
        setBolLogo()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        tableView.tableFooterView = UIView()
        
        // COMMENT: Registreer de cellen die in de tableview gebruikt worden
        tableView.register(UINib(nibName: ProductDetailCellType.ProductDetailCell.rawValue, bundle: nil), forCellReuseIdentifier: ProductDetailCellType.ProductDetailCell.rawValue)
        
        _loadDummyToolbar()
        
    }
    
    private func _loadDummyToolbar() {
        
        // COMMENT: Deze toolbar doet niks en is puur voor het design. Normaal gesproken zou ik een tabbarcontroller gebruiken.
        barView = ToolbarView.loadNib()
        toolbarView.addSubview(barView)
        barView?.translatesAutoresizingMaskIntoConstraints = false
        barView?.leftAnchor.constraint(equalTo: toolbarView.leftAnchor).isActive = true
        barView?.topAnchor.constraint(equalTo: toolbarView.topAnchor).isActive = true
        barView?.rightAnchor.constraint(equalTo: toolbarView.rightAnchor).isActive = true
        barView?.bottomAnchor.constraint(equalTo: toolbarView.bottomAnchor).isActive = true
        toolbarView.layoutIfNeeded()
        
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension ProductDetailViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let tableViewCell = cell  as?  GerelateerdeProductenCell else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.section)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let _ = presenter else { return 0 }
        return presenter.getNumberOfItemInRow()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let _ = presenter else { return UITableViewCell() }
        if presenter.isDataLoaded() {  
            let cellData = presenter.getCellData(row: indexPath.row)
            if  let cell = self.tableView.dequeueReusableCell(withIdentifier: cellData.celltype.rawValue),   let configCell = cell as? ProductDetailBaseCellProtocol   {
                if let recommendationCell = cell as? RecommendationCellProtocol {
                    recommendationCell.setDelegate(delegate: self)
                    recommendationCell.setData(data: cellData.data)
                } else {
                    configCell.setData(data: cellData.data)
                }
                return  configCell as! UITableViewCell
            }
        }
        return UITableViewCell()
    }
    
}

// MARK:  UICollectionViewDataSource , UICollectionViewDelegate
extension ProductDetailViewController : UICollectionViewDataSource , UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return presenter.getRelatedProducts().count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.setData(data: (presenter.getRelatedProducts()[indexPath.row]))
        return cell
    }
    
}

extension ProductDetailViewController :RecommendationProtocol {
    
    // COMMENT: Haalt het product op uit de aanraders / recommendations
    func getProductWith(id: String) {
        
        presenter.loadRecommendationProductWith(id:id)
        
    }
    
}


extension ProductDetailViewController : ProductDetailViewProtocol {
    
    func HideView() {
        
        DispatchQueue.main.async {
            self.toolbarView.isHidden = true
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
            self.tableView.isHidden = true
        }
        
    }
    
    func ShowView() {
        
        DispatchQueue.main.async {
            self.toolbarView.isHidden = false
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
            self.tableView.isHidden = false
        }
        
    }
    
    func ShowErrorMessage() {
        
        alertMessage(titel: "Oeps er ging iets mis!", message: "Helaas is de service op dit moment niet bereikbaar.\n Probeer het later opnieuw of conrtoleer uw internetverbinding.")
        
    }
 
    func ReloadData() {
        
        DispatchQueue.main.async {
  
            self.tableView.reloadData()
            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top , animated: true) // COMMENT: Zorgt er voor dat na het verversen dmv een Recommendation de table weer bovenaan staat
        }
        
    }
    
}


