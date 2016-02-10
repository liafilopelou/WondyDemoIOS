
import Foundation

class FavoritesManager {
    
    static let sharedInstance = FavoritesManager()
    let defaults = NSUserDefaults.standardUserDefaults()
    
    func contains(id: String) -> Bool {
        
        if favoriteIds()!.contains(id) {
            return true
        }
        else {
            return false
        }
    }
    
    func favoriteIds() -> [String]? {
        
        return defaults.arrayForKey("Favorites") as? [String]
    }
    
    func toggleFavorite(id: String) {
        
        var favoriteIdsTemp = favoriteIds() ?? [String]()
        if favoriteIdsTemp.contains(id) {
            let index = favoriteIdsTemp.indexOf(id)
            favoriteIdsTemp.removeAtIndex(index!)
        }
        else {
            favoriteIdsTemp.append(id)
        }
        defaults.setObject(favoriteIdsTemp, forKey: "Favorites")
    }
}
