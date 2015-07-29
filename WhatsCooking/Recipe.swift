
import Foundation
import CoreData

class Recipe: NSManagedObject {

    @NSManaged var id: String
    @NSManaged var imgURL: String
    @NSManaged var title: String
    @NSManaged var author: String

}
