
import UIKit
import MapleBacon

class CenterViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var scrollButon: UIButton!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    var center: Center?
    var descriptionIsHidden : Bool?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.title = self.center?.name
        
        self.descriptionTextView.text = (self.center?.description)! + "\n\nEncuentranos en: " + (self.center?.address)!
        self.descriptionTextView.layer.cornerRadius = 5
        self.descriptionTextView.textContainerInset = UIEdgeInsetsMake(20,20,20,20)
        self.descriptionIsHidden = false
        self.imageCollectionView.layer.cornerRadius = 5
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBarHidden = false
        self.transformCollectionView()
    }
    
    override func viewWillLayoutSubviews() {
        
        self.transformCollectionView()
    }
    
    func transformCollectionView() {
        
        let height = UIScreen.mainScreen().bounds.size.height
        self.collectionViewHeight.constant = height-120
        self.imageCollectionView.layoutIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        
        MapleBaconStorage.sharedStorage.clearMemoryStorage()
    }
    
    @IBAction func scrollButtonPressed(sender: UIButton) {
        
        if self.descriptionIsHidden == true {
            self.scrollView.setContentOffset(CGPointMake(self.scrollView.contentOffset.x, 0), animated: true)
            self.descriptionIsHidden = false
            self.scrollButon.setImage(UIImage(named: "Up_Arrow_Icon"), forState: .Normal)
        }
        else {
           self.scrollView.setContentOffset(CGPointMake(self.scrollView.contentOffset.x, self.scrollButon.frame.origin.y), animated: true)
            self.descriptionIsHidden = true
            self.scrollButon.setImage(UIImage(named: "Down_Arrow_Icon"), forState: .Normal)
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (self.center?.images?.count)!
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cellIdentifier = "CenterPhotoCollectionViewCell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! CenterPhotoCollectionViewCell
        
        if let imageURL = NSURL(string: (self.center?.images![indexPath.item])!), placeholder = UIImage(named: "Cell_Icon") {
            cell.photoImageView.setImageWithURL(imageURL, placeholder: placeholder)
        }
        cell.layer.borderColor = UIColor.grayColor().CGColor
        cell.layer.borderWidth = 1.5
        cell.layer.cornerRadius = 5
        
        return cell
    }
}
