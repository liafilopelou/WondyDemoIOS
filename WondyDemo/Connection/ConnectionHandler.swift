
import Foundation
import Alamofire
import AlamofireObjectMapper

class ConnectionHandler: NSObject {
    
    func fetchCenters(completionHandler: ([Center]?, NSError?) -> Void) {
        
        let url = ConnectionDataProvider.sharedInstance.centersURL
        
        Alamofire.request(.GET, url!).responseArray { (response: Response<[Center], NSError>) in
            
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
