
import UIKit

class JSONParser {
   
    init(){
        
    }
    
    class func parseRecipes(responseData: NSData) -> [Recipe]{
        
        var recipes : [Recipe] = []
        
        var jsonError: NSError?
        
        if let json = NSJSONSerialization.JSONObjectWithData(responseData, options: nil, error: &jsonError) as? NSDictionary{
                
            if let data =  json["data"] as? NSDictionary {
                if let entries =  data["entries"] as! NSArray?{
                    
                    for recipe in entries {
                            
                        if let recipe_dict = recipe as? NSDictionary {
                            
                            if let id = recipe_dict["id"] as! String! {
                               
                                if let title = recipe_dict["title"] as? String{
                                   
                                    if let author = recipe_dict["author"] as? String{
                                        
                                        if let imgURL = recipe_dict["imgURL"] as? String{
                                            
                                            API.sharedInstance.insertRecipe(id, title: title, imgURL: imgURL, author: author)
                                        }
                                    }
                                }
                            }
                            
                        }
                            
                    }
                        
                }
            }
        }
        
        return recipes
    }
    
}
