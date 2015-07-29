

import UIKit

class API {
   
    private let httpClient: HTTPClient;
    private let persistenceManager: PersistenceManager
    
    class var sharedInstance: API {
        
        struct Singleton {
            static let instance = API();
        }
        
        return Singleton.instance;
    }
    
    init() {
       
        httpClient = HTTPClient();
        persistenceManager = PersistenceManager()
    }
    
    func loadRecipes(){
        self.httpClient.loadRecipes()
    }
    
    func insertRecipe(id: String, title: String, imgURL: String, author: String){
        self.persistenceManager.insertRecipe(id, title: title, imgURL: imgURL, author: author)
    }
    
    func deleteRecipes(){
        self.persistenceManager.deleteRecipes()
    }
}
