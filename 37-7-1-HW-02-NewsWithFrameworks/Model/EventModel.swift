//
//  EventModel.swift
//  37-7-1-HW-02-NewsWithFrameworks
//
//  Created by Raman Kozar on 10/04/2023.
//

import Foundation
import ObjectMapper
import RealmSwift

class EventModel: Object, Mappable {
   
    @objc dynamic var author: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var myDescription: String = ""
    @objc dynamic var url: String = ""
    @objc dynamic var urlToImage: String = ""
    @objc dynamic var publishedAt: String = ""
    @objc dynamic var content: String = ""
    @objc dynamic var rowNumber: Int = 0
     
    override class func primaryKey() -> String? {
        return "publishedAt"
    }
    
    required convenience init?(map: ObjectMapper.Map) {
        self.init()
    }
    
    // Using ObjectMapper
    func mapping(map: ObjectMapper.Map) {

        author <- map["author"]
        title <- map["title"]
        myDescription <- map["description"]
        url <- map["url"]
        urlToImage <- map["urlToImage"]
        publishedAt <- map["publishedAt"]
        content <- map["content"]
        
    }
    
    func getCountFromDatabase() -> Int {
        
        let realm = try! Realm()
        realm.refresh()
        
        let array = realm.objects(EventModel.self).toArray(ofType: EventModel.self)
        return array.count > 0 ? array.count : 0
        
    }
    
    func getObjectsBySelection(currRow: Int) -> EventModel {
        
        let realm = try! Realm()
        realm.refresh()
        
        guard let connection = realm.objects(EventModel.self).filter("rowNumber == %@", currRow).first else { return EventModel() }
        return connection
        
    }
    
}

extension Results {
    
    func toArray<T>(ofType: T.Type) -> [T] {
        let array = Array(self) as! [T]
        return array
    }
    
}
