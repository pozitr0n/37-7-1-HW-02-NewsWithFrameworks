//
//  AlamofireRequest.swift
//  37-7-1-HW-02-NewsWithFrameworks
//
//  Created by Raman Kozar on 10/04/2023.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import RealmSwift

class Request {
    
    static func getData<T: Object>(type: T.Type, success: @escaping() -> Void, fail: @escaping(_ error: NSError) -> Void)
    where T: Mappable, T:DBModel {
        
        // Using Alamofire
        AF.request(T.urlAPI()).validate().responseObject { (response: AFDataResponse<T>) in
            
            switch response.result {
            case .success(let data):
                
                let dataArticles = data.dynamicList("articles")
                
                let realm = try! Realm()
                
                for item in dataArticles {
                    
                    try! realm.write {
                        realm.add(item, update: .all)
                    }
                    
                }
                success()
                
            case .failure(let error):
                fail(error as NSError)
            }
            
        }
        
    }
    
}

