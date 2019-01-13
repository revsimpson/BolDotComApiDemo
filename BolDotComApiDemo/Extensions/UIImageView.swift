//
//  UIImageView.swift
//  BolDotComAssesmment
//
//  Created by Richard Simpson on 03/11/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import Foundation
import UIKit

// COMMENT: Een extension op UIImageView om te zorgen dat plaatjes die geladen worden buiten de app om , op de achtergrond worden ingeladen en pas worden gepresenteerd als ze binnen zijn gekomen. De NSCache manager raadpleeg ik om te zorgen dat bij het snel heen en weer bewegen van een tableview niet de data voor de afbeelding opnieuw wordt opgehaald.
// COMMENT: De NSCache manager managed zichzelf zodat men zich niet druk hoeft te maken om memoryleaks.

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageFrom(urlString: String){
        let url = URL(string: urlString)
        
        image = nil
        contentMode = .scaleAspectFit
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
     
        URLSession.shared.dataTask(with: url!) {
            data, response, error in
            if let response = data {
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: response)
                    imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                    self.image = imageToCache
                }
            }
            }.resume()
    }
    
    // COMMENT: Extension gemaakt om de ratings te zetten van een product
    func setRatingImageWith(score:Int) {
        var NumberOfStars = 0
        switch score {
        case ..<25 :
            NumberOfStars = 2
        case  26...34 :
            NumberOfStars = 3
        case 35...44 :
            NumberOfStars = 4
        case 44...50 :
            NumberOfStars = 5
        default:
            break
        }
        
        self.image = UIImage(named: "\(NumberOfStars)star")
    }
    
}



