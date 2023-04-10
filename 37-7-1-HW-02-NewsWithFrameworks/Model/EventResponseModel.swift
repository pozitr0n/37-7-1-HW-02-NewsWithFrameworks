//
//  EventResponseModel.swift
//  37-7-1-HW-02-NewsWithFrameworks
//
//  Created by Raman Kozar on 10/04/2023.
//

import Foundation
import ObjectMapper
import RealmSwift

class EventResponseModel: Object, Mappable, DBModel {
    
    @objc dynamic var status: String = ""
    @objc dynamic var totalResults: Int = 0
    
    var articles = List<EventModel>()

    required convenience init?(map: ObjectMapper.Map) {
        self.init()
    }
    
    static func urlAPI() -> String {
        return "https://newsapi.org/v2/everything?q=android&from=2019-04-00&sortBy=publi%20shedAt&apiKey=0761544563ac4a43b7ab0cc56b49d932&page=1"
    }
    
    func mapping(map: ObjectMapper.Map) {
        
        totalResults <- map["totalResults"]
        status <- map["status"]
        
        let mapper_articiles = Mapper<EventModel>().mapArray(JSONObject: map["articles"].currentValue)
        
        if let mapper_articiles = mapper_articiles {
            articles.append(objectsIn: mapper_articiles)
        }
        
    }
}
