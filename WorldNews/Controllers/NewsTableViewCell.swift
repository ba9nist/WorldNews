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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(url: String, title: String, description: String){
//        ApiTypes.sharedInstance.getImage(url: url, completionHandler: { (image) in
//            self.articleImage.image = image
//        })
        self.articleImage.af_setImage(withURL: URL(string: url)!)
        
        articleTitle.text = title
        articleDescription.text = description
    }
    
}
