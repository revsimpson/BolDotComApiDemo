//
//  ProductPresenter.swift
//  BolDotComAssesmment
//
//  Created by Richard Simpson on 31/10/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import Foundation

class TextSeachPresenter {
    private let interactor : TextSearchInteractorProtocol
    private let view : TextSearchViewProtocol
    
    init(interactor:TextSearchInteractorProtocol, view:TextSearchViewProtocol) {
        self.interactor = interactor
        self.view = view
    }
}

// MARK: ProductPresenterProtocol
extension TextSeachPresenter:TextSearchPresenterProtocol {
    
    // COMMENT:  Ophalen van de zoeksuggesties. "data" is standaard een lege string array , zodat je bij nil als searchResult waarde niks extra's hoeft te doen.
    // COMMENT:  "data" wordt na de handeling van de Interactor door de Presenter doorgegeven aan de View
    
    func getSearchSuggestions(text:String) {
        var data = [String]()
        interactor.getSearchTextResult(searchText: text) { (searchResult) in
            
            if let result = searchResult {
                data = result.resultArray
                self.view.setSearchData(searchResult: data)
            } else {
                DispatchQueue.main.async {
                    alertMessage(titel: "Oeps er gaat wat mis!", message: "De zoek service is tijdelijk niet bereikbaar\nProbeer het later nog een keer!")
                }
            }
            
        }
    }
    
    
    // COMMENT: Geef aan de view door dat de data leeg moet zijn. Dit mag geen [""] want dat wordt gezien als een lege string waardoor je een lege cell zou krijgen.
    
    func resetData(){
        view.setSearchData(searchResult: [])
    }
}




