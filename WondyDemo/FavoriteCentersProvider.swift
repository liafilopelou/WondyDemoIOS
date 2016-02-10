
import Foundation
import ObjectMapper

class FavoriteCentersProvider: NSObject, CentersProvider {

    func fetchCenters(completionHandler: ([Center]?, NSError?) -> Void) {
        
        let mapper = Mapper<Center>()
        let centersJSONString = NSUserDefaults.standardUserDefaults().objectForKey("Centers")
        let centers = mapper.mapArray(centersJSONString)

        let favoriteIds = FavoritesManager.sharedInstance.favoriteIds()
        
        let favoriteCentersRx = centers?.enumerate()
            .filter({ (index: Int, element: Center) -> Bool in
                if let favoriteIds = favoriteIds {
                    return favoriteIds.contains(element.id!)
                } else {
                    return false
                }
            })
            .map({ (index: Int, element: Center) -> Center in
                return element
            })
        
        completionHandler(favoriteCentersRx, nil)
        
    }
}
