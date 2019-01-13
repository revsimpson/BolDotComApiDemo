//
//  ProductSearchResultViewController.swift
//  BolDotComAssesmment
//
//  Created by Richard Simpson on 02/11/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import UIKit
import Foundation

class ProductSearchResultViewController: UIViewController {
   
    @IBOutlet var headerText: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    
    private var presenter :  ProductSearchResultPresenterProtocol!
    
    var searchText = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
          presenter = ProductSearchResultPresenter(interactor: ProductSearchResultInteractor(), view: self, searchText: searchText)
        _configure()
        presenter.viewDidLoad()
        
    }
    
    private func _configure(){
        
        setBolLogo()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        tableView.tableFooterView = UIView()
        let cellType = presenter.getCellType()
        tableView.register(UINib(nibName: cellType, bundle: nil), forCellReuseIdentifier: cellType)
        
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource 
extension ProductSearchResultViewController : UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let _ = presenter else { return 0 }
        return presenter.getNumberOfItemInRow()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let _ = presenter else { return UITableViewCell() }
        let cellData = presenter.getCellData()
        if  let cell = self.tableView.dequeueReusableCell(withIdentifier: presenter.getCellType()), let configCell = cell as? ProducSearchResultCell {
            configCell.setData(data: cellData[indexPath.row])
            return configCell
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductDetailViewController") as? ProductDetailViewController {
            
            viewController.productId = presenter.getCellData()[indexPath.row].productId
            NavigationRetainer.shared.getNavigationController().pushViewController(viewController, animated: true)
        }
    }
    
}

extension ProductSearchResultViewController : ProductSearchResultViewProtocol {
    
    func HideView() {
        
        DispatchQueue.main.async {
            self.headerText.isHidden = true
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
            self.tableView.isHidden = true
        }
        
    }
    
    func ShowView() {
        
         DispatchQueue.main.async {
            self.headerText.isHidden = false
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
        }
        
    }
    
}
