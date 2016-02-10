
import Foundation
import ObjectMapper

class RemoteCentersProvider: NSObject, CentersProvider {
    
    func fetchCenters(completionHandler: ([Center]?, NSError?) -> Void) {
        
        ConnectionHandler().fetchCenters({ (centers, error) -> Void in
            if let centersArray = centers {
                let mapper = Mapper<Center>()
                NSUserDefaults.standardUserDefaults().setObject(mapper.toJSONArray(centersArray), forKey: "Centers")
                completionHandler(centers, nil)
            }
        })
        
    }
}
