
import UIKit

class MenuContainerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userPhotoImageView: UIImageView!
    
    let items = ["Lista de centros", "Centros en mapa", "Perfil", "Favoritos"]
    let menuItems: [String: String] = ["Lista de centros": "CenterTableNavigationController", "Centros en mapa": "CenterMapNavigationController", "Perfil": "UserProfileNavigationController", "Favoritos": "CenterTableNavigationController"]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorColor = UIColor(red: 214/255.0, green: 138/255.0, blue: 142/255.0, alpha:1)
        self.tableView.backgroundColor = UIColor(white: 0.0, alpha: 0.1)
        
        self.view.backgroundColor = UIColor(red: 214/255.0, green: 138/255.0, blue: 142/255.0, alpha: 0.8)
        
        self.userPhotoImageView.backgroundColor = UIColor.whiteColor()
        self.userPhotoImageView.layer.cornerRadius = self.userPhotoImageView.frame.size.height/2
        self.userPhotoImageView.layer.borderWidth = 3.0
        self.userPhotoImageView.layer.borderColor = UIColor.whiteColor().CGColor
        self.userPhotoImageView.clipsToBounds = true
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated);
        self.updateProfilePicture()
    }
    
    func updateProfilePicture() {
        
        let imageData = NSUserDefaults.standardUserDefaults().objectForKey("UserProfileImage") as? NSData
        if let data = imageData {
            self.userPhotoImageView.image = UIImage(data: data)
        }
        else {
            self.userPhotoImageView
                .image = UIImage(named: "Profile_Icon")
        }
    }
    
    func changeViewController(menuItem: String) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        switch menuItem {
        case "Lista de centros":
            self.slideMenuController()?.changeMainViewController(storyboard.instantiateViewControllerWithIdentifier(menuItems["Lista de centros"]!) as! UINavigationController, close: true)
        case "Centros en mapa":
            self.slideMenuController()?.changeMainViewController(storyboard.instantiateViewControllerWithIdentifier(menuItems["Centros en mapa"]!) as! UINavigationController, close: true)
        case "Perfil":
            self.slideMenuController()?.changeMainViewController(storyboard.instantiateViewControllerWithIdentifier(menuItems["Perfil"]!) as! UINavigationController, close: true)
        case "Favoritos":
            self.slideMenuController()?.changeMainViewController(storyboard.instantiateViewControllerWithIdentifier(menuItems["Favoritos"]!) as! UINavigationController, close: true)
        default:
            return
        }
    }
    
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("MenuItemCell", forIndexPath: indexPath)
        let myItem = items[indexPath.row]
        
        cell.textLabel?.text = myItem
        cell.textLabel?.textColor = UIColor.whiteColor()
        //cell.backgroundColor = UIColor(red: 214/255.0, green: 138/255.0, blue: 142/255.0, alpha: 0.8)
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        self.changeViewController(items[indexPath.row])
    }
}
