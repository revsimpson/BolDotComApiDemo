//
//  NavigationRetainer.swift
//
//  Created by Richard Simpson on 05/11/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//
import UIKit
import Foundation

// COMMENT: Met de nagivation retainer hoef ik geen delegates te maken vanaf een tableviewCell om een aangeklikte butten te registeren die een transitie naar een pagina wil doen.
// COMMENT: Door de retainer te gebruiken zit men altijd op de juist NavigationController. Als men naar een ander storyboard zou gaan kan de NavigationRetainer overschreven worden.
class NavigationRetainer {
    
    static let shared = NavigationRetainer()
    
    private var readTextViewController : ReadTextViewController!
    private var navigationController : UINavigationController!
    
    func set(nc:UINavigationController) {
        navigationController = nc
    }
    
    func getNavigationController() -> UINavigationController{
        return navigationController
    }
    
    func loadReadTextViewController() {
        readTextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReadTextViewController") as? ReadTextViewController
    }
    
    func getReadTextViewController() -> ReadTextViewController {
        return readTextViewController
    }
    
}
