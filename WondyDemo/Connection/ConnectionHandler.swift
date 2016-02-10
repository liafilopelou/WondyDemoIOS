
import Foundation
import Alamofire
import AlamofireObjectMapper

class ConnectionHandler: NSObject {
    
    var centersURL: String? {
        
        let bundle = NSBundle.mainBundle()
        if let bundlePath = bundle.pathForResource("ConnectionData", ofType: "plist") {
            let connectionDict = NSDictionary(contentsOfFile: bundlePath)
            return connectionDict!["CentersURL"] as? String
        }
        else {
            return nil
        }
    }
    
    func fetchCenters(completionHandler: ([Center]?, NSError?) -> Void) {
        
        Alamofire.request(.GET, self.centersURL!).responseArray { (response: Response<[Center], NSError>) in
            
            if let error = response.result.error {
                completionHandler(nil, error)
                return
            }
            
            let centersArray = response.result.value
            
            if let centersArray = centersArray {
                completionHandler(centersArray, nil)
            }
        }
    }

}
