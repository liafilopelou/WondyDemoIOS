
import Foundation
import ObjectMapper

class Center: Mappable {
    
    var id: String?
    var name: String?
    var address: String?
    var longitude: Double?
    var latitude: Double?
    var images: [String]?
    var services: [String]?
    var description: String?
    
    required init?(_ map: Map) {

        mapping(map)
    }
    
    func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
        address <- map["address"]
        longitude <- (map["long"], TransformOf<Double, String>(fromJSON: { Double($0!) }, toJSON: { $0.map { String($0) } }))
        latitude <- (map["lat"], TransformOf<Double, String>(fromJSON: { Double($0!) }, toJSON: { $0.map { String($0) } }))
        images <- map["img"]
        services <- map["services"]
        description <- map["desc"]
    }
    
}