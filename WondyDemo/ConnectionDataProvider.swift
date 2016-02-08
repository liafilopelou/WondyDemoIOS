
import Foundation

class ConnectionDataProvider {
    
    static let sharedInstance = ConnectionDataProvider()
    
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
}

