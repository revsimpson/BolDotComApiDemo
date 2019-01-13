//
//  ViewController.swift
//  BolDotComAssesmment
//
//  Created by Richard Simpson on 31/10/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import UIKit
import Foundation

class TextSearchViewController: UIViewController {
   
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var bottomConstraintBolPop: NSLayoutConstraint!
    
    var presenter :  TextSearchPresenterProtocol!
    var searchResults = [String]()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
       _configure()
        presenter = TextSeachPresenter(interactor: TextSeachInteractor(), view: self)
    }
    
    private func _configure() {
        
        tableView.dataSource = self
        searchBar.delegate = self
        tableView.tableFooterView = UIView()
        setBolLogo()
        NavigationRetainer.shared.set(nc: self.navigationController!)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
       _handlePopShow()
        _checkInternetConnection()
        
    }
    
    private func _checkInternetConnection() {
        
        if !CheckInternet.Connection() {
            alertMessage(titel: "Geen internet", message: "Op dit moment kan je toestel geen verbinding maken met internet , probeer het later opnieuw! ")
        }
        
    }
    
    private func _handlePopShow() {
        
        if tableView.numberOfRows(inSection: 0) > 0 {
            _StartBolPopAnimation(bottomConstraint:-220)
        } else {
            _StartBolPopAnimation(bottomConstraint:10)
        }
        
    }
    
    private func _StartBolPopAnimation(bottomConstraint: CGFloat) {
        
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 1.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 3, options: .curveLinear, animations: {
            self.bottomConstraintBolPop.constant = bottomConstraint
            self.view.layoutIfNeeded()
        }) { _ in
        }
    }
    
}

// MARK: UITableViewDelegate, UITableViewDataSource

extension TextSearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            cell?.textLabel?.text = searchResults[indexPath.row]
        return cell ?? UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return searchResults.count
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductSearchResultViewController") as? ProductSearchResultViewController {
            
            viewController.searchText = searchResults[indexPath.row]
            NavigationRetainer.shared.getNavigationController().pushViewController(viewController, animated: true)
        }
        
    }
}

// MARK: UISearchBarDelegate
extension TextSearchViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchText == "" ?  presenter.resetData() : presenter.getSearchSuggestions(text: searchText)
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
    }
}

// MARK: TextSearchViewProtocol
extension TextSearchViewController:  TextSearchViewProtocol {
    
    func setSearchData(searchResult:[String]) {
        
        searchResults = searchResult

        DispatchQueue.main.async {
            self.tableView.reloadData()
            self._handlePopShow()
        }
    }
    
}







