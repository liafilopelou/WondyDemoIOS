
import UIKit
import MapKit

class MapCenter: NSObject, MKAnnotation {
    
    var title: String?
    var subtitle: String?
    var latitude: Double
    var longitude:Double
    var centerInfo: Center?
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    init(_ centerInfo: Center) {
        
        self.centerInfo = centerInfo
        self.latitude = centerInfo.latitude!
        self.longitude = centerInfo.longitude!
        self.title = centerInfo.name!
        self.subtitle = centerInfo.address!
    }

}
