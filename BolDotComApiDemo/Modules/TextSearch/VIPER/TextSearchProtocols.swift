//
//  Protocols.swift
//  BolDotComAssesmment
//
//  Created by Richard Simpson on 31/10/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import Foundation

protocol TextSearchPresenterProtocol {
    
    func getSearchSuggestions(text:String)
    func resetData()
    
}

protocol TextSearchViewProtocol {
    
    func setSearchData(searchResult:[String])
    
}

protocol TextSearchInteractorProtocol {
    
    func getSearchTextResult(searchText:String, completion: @escaping(SearchResult?)->Void)
    
}
