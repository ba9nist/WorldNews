//
//  SourceObject.swift
//  WorldNews
//
//  Created by ba9nist on 31.10.17.
//  Copyright © 2017 ba9nist. All rights reserved.
//

import UIKit
import SwiftyJSON

class SourceObject: NSObject{
    
    var source: String?
    var name: String?
    var about: String?
    var url: String?
    var category: String?
    var language: String?
    var country: String?
    
    
    override init(){
        super.init()
    }
    
    init(json: JSON){
        source = json["id"].string
        name = json["name"].string
        about = json["description"].string
        url = json["url"].string
        category = json["category"].string
        language = json["language"].string
        country = json["country"].string
        
//        print(source!)
    }

    
}
