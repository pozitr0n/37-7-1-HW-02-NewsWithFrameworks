//
//  ViewController.swift
//  37-7-1-HW-02-NewsWithFrameworks
//
//  Created by Raman Kozar on 09/04/2023.
//

import UIKit
import SafariServices
import RealmSwift

class MainTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getTheNewsFromAPIWithMapping()
    }
    
    func getTheNewsFromAPIWithMapping() {
       
        // Using ObjectMapping + Realm framework
        Request.getData(type: EventResponseModel.self, success: {
            
            var currRow: Int = 0
            
            let realm = try! Realm()
            realm.refresh()
            let elements = realm.objects(EventModel.self)
            
            for elem in elements {
            
                try! realm.write {
                    elem.rowNumber = currRow
                }
                
                currRow += 1
                
            }
            
            self.tableView.reloadData()
            print("Success")
            
        }, fail: { error in
            print("Error \(error.description)")
        })
       
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventModel().getCountFromDatabase()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let newsCell = tableView.dequeueReusableCell(withIdentifier: "MyNewsCell", for: indexPath) as? MyNewsCell
        else {
            return UITableViewCell()
        }
        
        let currRow = indexPath.row
        newsCell.fillTheInformation(dataInfo: EventModel().getObjectsBySelection(currRow: currRow))
        
        return newsCell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currRow = indexPath.row
        let currValue = EventModel().getObjectsBySelection(currRow: currRow)
        
        let urlString = currValue.url
        
        if !urlString.isEmpty {
            
            let url = URL(string: urlString)!
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true)
            
        } else {
            
            let url = URL(string: "https://google.com")!
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true)
            
        }
        
    }

}

