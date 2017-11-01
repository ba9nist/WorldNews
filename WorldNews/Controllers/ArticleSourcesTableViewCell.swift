//
//  ArticleSourcesTableViewCell.swift
//  WorldNews
//
//  Created by ba9nist on 01.11.17.
//  Copyright © 2017 ba9nist. All rights reserved.
//

import UIKit

class ArticleSourcesTableViewCell: UITableViewCell {

    @IBOutlet weak var sourceHeader: UILabel!
    @IBOutlet weak var sourceLanguageImage: UIImageView!
    @IBOutlet weak var sourceDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupData(sourceObject: SourceObject){
        sourceLanguageImage.image = nil
        sourceHeader.text = sourceObject.name
        sourceDescription.text = sourceObject.about
        
        switch(sourceObject.language){
            case "en":
                sourceLanguageImage.image = #imageLiteral(resourceName: "United-Kingdom-flag-icon")
            break
            case "de":
                sourceLanguageImage.image = #imageLiteral(resourceName: "Germany-Flag-icon")
            break
            case "fr":
                sourceLanguageImage.image = #imageLiteral(resourceName: "France-Flag-icon")
            break
        default:
            print("undefined language")
        }
        
    }
    
}
