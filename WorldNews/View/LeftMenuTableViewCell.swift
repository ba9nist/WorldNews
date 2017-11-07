//
//  LeftMenuTableViewCell.swift
//  WorldNews
//
//  Created by ba9nist on 07.11.17.
//  Copyright © 2017 ba9nist. All rights reserved.
//

import UIKit

class LeftMenuTableViewCell: UITableViewCell {



    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupData(name: String, image: UIImage){
        leftImage.image = image
        label.text = name
    }
    
}
