//
//  Article.swift
//  WorldNews
//
//  Created by ba9nist on 31.10.17.
//  Copyright © 2017 ba9nist. All rights reserved.
//

import UIKit
import SwiftyJSON

class Article: NSObject {
    var author: String!
    var title: String!
    var about: String!
    var url: String!
    var imageUrl: String!
    var publishedAt: String!
    
    
    init(json: JSON){
        author = json["author"].string
        title = json["title"].string
        about = json["description"].string
        url = json["url"].string
        imageUrl = json["urlToImage"].string
        publishedAt = json["publishedAt"].string
        
//        print("author = \(author!) title = \(title!)")
    }
}
