
import UIKit
import MBProgressHUD
import SlideMenuControllerSwift

class CenterTableViewController: UITableViewController {
    
    var centers = [Center]()
    var centersProvider : CentersProvider?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.title = "Centros"
        self.addLeftBarButtonWithImage(UIImage(named: "Menu_Icon")!)
        self.tableView.separatorColor = UIColor(red: 214/255.0, green: 138/255.0, blue: 142/255.0, alpha: 1)
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBarHidden = false
        self.loadCenters()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        var count = 0
        if self.centers.count > 0 {
            self.tableView.separatorStyle = .SingleLine
            count = 1
        }
        return count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.centers.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "CenterTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CenterTableViewCell
        
        let centerForCell = self.centers[indexPath.row]
        cell.title.text = centerForCell.name
        cell.subtitle.text = centerForCell.address
        
        if let imageURL = NSURL(string: (self.centers[indexPath.item].images![1])), placeholder = UIImage(named: "Cell_Icon") {
            cell.icon.setImageWithURL(imageURL, placeholder: placeholder)
        }
        cell.icon.layer.cornerRadius = 8
        cell.icon.clipsToBounds = true

        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "ShowCenterSegue" {
            if let destination = segue.destinationViewController as? CenterViewController {
                if let centerIndex = tableView.indexPathForSelectedRow?.row {
                    destination.center = self.centers[centerIndex]
                }
            }
        }
    }
    
    func loadCenters() {
        
        let hub = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hub.mode = .Indeterminate
        hub.dimBackground = true
        hub.labelText = "Cargando"
        self.centersProvider?.fetchCenters({ (centers, error) -> Void in
            if let centers = centers {
                self.centers = centers
                self.tableView.reloadData()
                hub.hide(true)
            }
        })
    }
}
