//
//  ArticleSourcesCollectionViewCell.swift
//  WorldNews
//
//  Created by ba9nist on 07.11.17.
//  Copyright © 2017 ba9nist. All rights reserved.
//

import UIKit

class ArticleSourcesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var about: UILabel!
    @IBOutlet weak var language: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupData(sourceObject: SourceObject){
        category.text = sourceObject.category
        title.text = sourceObject.name
        about.text = sourceObject.about
        switch(sourceObject.language){
        case "en":
            language.image = #imageLiteral(resourceName: "United-Kingdom-flag-icon")
            break
        case "de":
            language.image = #imageLiteral(resourceName: "Germany-Flag-icon")
            break
        case "fr":
            language.image = #imageLiteral(resourceName: "France-Flag-icon")
            break
        default:
            print("undefined language")
        }
    }

}
