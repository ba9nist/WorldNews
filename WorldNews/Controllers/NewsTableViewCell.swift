//
//  NewsTableViewCell.swift
//  WorldNews
//
//  Created by ba9nist on 31.10.17.
//  Copyright © 2017 ba9nist. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleDescription: UILabel!
    @IBOutlet weak var articleTitle: UILabel!
    var url: String = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(url: String, title: String, description: String){
        self.url = url
        articleImage.image = nil
//        NewsApi.sharedInstance.getImage(url: url, completionHandler: { (image) in
//            self.articleImage.image = image
//        })
        
        NewsApi.sharedInstance.getImage(url: url) { (image, resultUrl) in
            if(self.url == resultUrl){
                self.articleImage.image = image
            }else{
                print ("late Image")
            }
        }
        
        //self.articleImage.af_setImage(withURL: URL(string: url)!)
        
        articleTitle.text = title
        articleDescription.text = description
    }
    
}
