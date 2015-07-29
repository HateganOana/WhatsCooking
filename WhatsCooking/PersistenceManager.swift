
import UIKit
import CoreData

class PersistenceManager {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    func insertRecipe(id: String, title: String, imgURL: String, author: String){
        
        let recipe = NSEntityDescription.insertNewObjectForEntityForName("Recipe", inManagedObjectContext: self.managedObjectContext!) as! Recipe
        
        recipe.id = id
        recipe.title = title
        recipe.author = author
        recipe.imgURL = imgURL
        
        var error: NSError?
        if (!(self.managedObjectContext!.save(&error)) ){
            println("An error occurred: \(error), \(error?.userInfo)")
        }
        
    }
    
    func deleteRecipes(){
        
        let fetchRequest = NSFetchRequest(entityName: "Recipe")
        let fetchedEntities = self.managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as! [Recipe]
        
        for entity in fetchedEntities {
            self.managedObjectContext!.deleteObject(entity)
        }
        
        var error: NSError?
        if (!(self.managedObjectContext!.save(&error)) ){
            println("An error occurred: \(error), \(error?.userInfo)")
        }
    }
   
}
