
import UIKit
import CoreData


class RecipesViewController: UIViewController {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        
        let recipesFetchRequest = NSFetchRequest(entityName: "Recipe")
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        recipesFetchRequest.sortDescriptors = [sortDescriptor]
        
        let frc = NSFetchedResultsController(fetchRequest: recipesFetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
        
        frc.delegate = self
        
        return frc
        }()
    
    var recipesTableView: UITableView!
    
    var bottomConstraint: NSLayoutConstraint?
    var heightConstraint: NSLayoutConstraint?
    let recipeRowHeight = CGFloat(180)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.blackColor()
        
        recipesTableView = UITableView(frame: CGRectMake(0, 30, self.view.bounds.width, UIScreen.mainScreen().bounds.height - 30 ))
        recipesTableView.backgroundColor = UIColor.blackColor()
        recipesTableView.dataSource = self
        recipesTableView.rowHeight = recipeRowHeight
        recipesTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.view.addSubview(recipesTableView)
        recipesTableView.registerClass(RecipeCell.classForCoder(), forCellReuseIdentifier: "RecipeCell")
        
        var error: NSError? = nil
        if (!fetchedResultsController.performFetch(&error)) {
            print("An error occurred: \(error?.localizedDescription)")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    func addKeyboardListeners(){
        
        var center: NSNotificationCenter = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: "keyboardWillChabgeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    
    func keyboardWillChabgeFrame(notification: NSNotification) {
        
        let userInfo = notification.userInfo!
        
        let animationDuration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let convertedKeyboardEndFrame = view.convertRect(keyboardEndFrame, fromView: view.window)
        
        bottomConstraint!.constant = -(CGRectGetMaxY(view.bounds) - CGRectGetMinY(convertedKeyboardEndFrame))
        
        UIView.animateWithDuration(animationDuration, delay: 0.0, options: .BeginFromCurrentState | UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    
}

extension RecipesViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let rec = self.fetchedResultsController.sections![section] as! NSFetchedResultsSectionInfo
        return rec.numberOfObjects
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell : RecipeCell? = tableView.dequeueReusableCellWithIdentifier("RecipeCell", forIndexPath: indexPath) as? RecipeCell
        
        if cell == nil {
            cell = RecipeCell(style: UITableViewCellStyle.Default, reuseIdentifier: "RecipeCell")
        }
        
        self.configureCell(cell!, atIndexPath: indexPath)
        return cell!
    }
    
    
    func configureCell(cell: RecipeCell, atIndexPath indexPath: NSIndexPath) {
        
        let recipe = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Recipe
        
        let url = NSURL(string: recipe.imgURL)
        cell.backgroundImg.sd_setImageWithPreviousCachedImageWithURL(url, andPlaceholderImage: nil, options: nil, progress: nil, completed: {(image: UIImage!, error: NSError!, cacheType: SDImageCacheType, imageURL: NSURL!) -> Void in
            
        })
        
        cell.titleLabel.text = recipe.title.uppercaseString
        cell.titleLabel.sizeToFit()
        
        cell.subtitleLabel.text = recipe.author
        cell.subtitleLabel.frame.origin.y = cell.titleLabel.frame.origin.y + cell.titleLabel.frame.size.height + 5
        cell.subtitleLabel.sizeToFit()
        
    }
    
    
}


extension RecipesViewController: NSFetchedResultsControllerDelegate{
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.recipesTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.recipesTableView.endUpdates()
    }
    
    
    func controller(controller: NSFetchedResultsController, didChangeObject object: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            self.recipesTableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        case .Update:
            let cell = self.recipesTableView.cellForRowAtIndexPath(indexPath!) as! RecipeCell
            self.configureCell(cell, atIndexPath: indexPath!)
            self.recipesTableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        case .Move:
            self.recipesTableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
            self.recipesTableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        case .Delete:
            self.recipesTableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        default:
            return
        }
    }
    
}




