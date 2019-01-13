//
//  TextSeachInteractor
//  BolDotComAssesmment
//
//  Created by Richard Simpson on 31/10/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import Foundation

class TextSeachInteractor { }

// MARK : ProductProtocol
extension TextSeachInteractor : TextSearchInteractorProtocol {
    
    // Haal catalog gegevens op.
    func getSearchTextResult(searchText:String, completion: @escaping(SearchResult?)->Void)  {
        
        // COMMENT: Ophalen van de textsuggesties. De addingPErcentEncoding zorgt ervoor dat ook spaties worden geaccepteerd in de zoek query.
        let urlString = "\(ServerPaths.TextSuggesties.getpath())\(searchText)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        guard let catalogUrl =  URL(string:urlString!) else { return }
        
        URLSession.shared.dataTask(with: catalogUrl) { (data, response
            , error) in
         
            guard let data = data else {
                
                completion(nil) // extra completion return voor als men blijft typen is de searchbox
                return }
            do {
                
                let decoder = JSONDecoder()
                let searchData = try decoder.decode(SearchResult.self, from: data)
                completion(searchData)
                
            } catch {
                
                completion(nil)
          
            }
            }.resume()
    }
}

