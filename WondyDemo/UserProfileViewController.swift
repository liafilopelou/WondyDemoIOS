
import UIKit
import SlideMenuControllerSwift

class UserProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.title = "Mi perfil"
        self.addLeftBarButtonWithImage(UIImage(named: "Menu_Icon")!)
        self.photoImageView.layer.cornerRadius = self.photoImageView.frame.size.height/2
        self.photoImageView.layer.borderWidth = 3.0
        self.photoImageView.layer.borderColor = UIColor(red: 214/255.0, green: 138/255.0, blue: 142/255.0, alpha: 0.5).CGColor
        self.photoImageView.clipsToBounds = true
        let imageData = NSUserDefaults.standardUserDefaults().objectForKey("UserProfileImage") as? NSData
        if let data = imageData {
            self.photoImageView.image = UIImage(data: data)
        }
        else {
            self.photoImageView.image = UIImage(named: "Profile_Icon")
        }
        
        self.contentView.layer.cornerRadius = 10
    }

    @IBAction func photoButtonPressed(sender: UIButton) {
        
        self.changeProfilePicture()
    }
    
    func changeProfilePicture() {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .PhotoLibrary
        imagePickerController.delegate = self
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        photoImageView.image = selectedImage
        NSUserDefaults.standardUserDefaults().setObject(UIImagePNGRepresentation(selectedImage), forKey: "UserProfileImage")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
}