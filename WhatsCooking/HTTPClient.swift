

import UIKit

class HTTPClient {
    
    
    func loadRecipes(){
        
        let recipesURL: String = "https://jsonblob.com/api/55b86f7ae4b0f6d7e5bdec8b"
        loadDataFromURL(NSURL(string: recipesURL)!, completion:{(data, error) -> Void in
            
            if let urlData = data {
                let data : NSData = urlData as NSData
                let recipes : [Recipe] = JSONParser.parseRecipes(data)
            }
        })

    }
    
    func loadDataFromURL(url: NSURL, completion:(data: NSData?, error: NSError?) -> Void) {
        
        var request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        var reponseError: NSError?
        var response: NSURLResponse?
        
        var urlData: NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&reponseError)
        
        if let httpResponse = response as? NSHTTPURLResponse {
            
            if httpResponse.statusCode != 200 {
                completion(data: nil, error: reponseError)
            }
            else {
                completion(data: urlData, error: nil)
            }
        }
    }

   
}
