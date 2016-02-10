
import Foundation

protocol CentersProvider {
    
    func fetchCenters(completionHandler: ([Center]?, NSError?) -> Void)
}