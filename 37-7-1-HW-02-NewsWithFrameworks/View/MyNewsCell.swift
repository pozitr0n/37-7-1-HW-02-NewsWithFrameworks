//
//  MyNewsCell.swift
//  37-7-1-HW-02-NewsWithFrameworks
//
//  Created by Raman Kozar on 09/04/2023.
//

import UIKit
import Kingfisher

class MyNewsCell: UITableViewCell {

    @IBOutlet weak var titleNews: UILabel!
    @IBOutlet weak var dateNews: UILabel!
    @IBOutlet weak var descriptionNews: UILabel!
    @IBOutlet weak var imageForNews: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fillTheInformation(dataInfo: EventModel) {
        
        titleNews.text = dataInfo.title
        dateNews.text = dataInfo.publishedAt
        descriptionNews.text = dataInfo.myDescription
        
        let url = dataInfo.urlToImage
            
        if let urlForGettingImage = URL(string: url) {
            // Using Kingfisher framework
            imageForNews.kf.setImage(with: urlForGettingImage)
        } else {
            imageForNews.image = UIImage(named: "error-404.png")!
        }
        
    }

}
