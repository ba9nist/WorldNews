//
//  ApiTypes.swift
//  WorldNews
//
//  Created by ba9nist on 31.10.17.
//  Copyright © 2017 ba9nist. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class NewsApi: NSObject {
    
    let apiKey = "37543c1f01b7455ba38401d4bfcd6688"
    
    let imageCache = AutoPurgingImageCache(
        memoryCapacity: 100*1024*1024,
        preferredMemoryUsageAfterPurge: 60*1024*1024
    )
    
    let size = CGSize(width: 83.0, height: 83.0)

    static let sharedInstance = NewsApi()

    private override init(){super.init()}

    func getImage(url: String, completionHandler: @escaping (Image) -> ()){
        let img = getImageFromCache(url: url);
        
        if(img != nil){
            completionHandler(img!);
            return;
        }
        
        Alamofire.request(url, method:.get).responseImage { (response) in
            guard let image = response.result.value else { return }
            let scaledImage = image.af_imageScaled(to: self.size)
            self.cache(image: scaledImage, url: url)
            completionHandler(scaledImage)
        }
    }
    
    func cache(image: Image, url: String){
        imageCache.add(image, withIdentifier: url)
    }
    
    func getImageFromCache(url: String) ->Image? {
        return imageCache.image(withIdentifier: url)
    }
    
    
    
    func getAricles(completionHandler: @escaping ([Article]?, Error?) -> ()){
        let url = "https://newsapi.org/v1/articles?source=techcrunch&apiKey=37543c1f01b7455ba38401d4bfcd6688"
        Alamofire.request(url).validate()
        .responseJSON { (response) in
            switch(response.result){
            case .success:
                var articles: [Article] = []
                
                let jsonResult = JSON(data: response.data!)
                for article in (jsonResult["articles"].array)!{
                    articles.append(Article(json: article))
                }
                completionHandler(articles,nil)
                break
            case .failure:
                completionHandler(nil, response.result.error)
                break
            }
        }
    }
    
//    func getAllSources(){
//        print("getting all sources");
//        let url = "https://newsapi.org/v1/sources"
//        Alamofire.request(
//            url,
//            method: .get,
//            parameters: nil)
//            .validate()
//            .responseJSON { (response) -> Void in
//                guard response.result.isSuccess else {
//                    //completion(nil, response.result.error)
//                    return
//                }
//                
//                var sources: [SourceObject] = []
//                
//                let jsonResult = JSON(data: response.data!)
//                for source in (jsonResult["sources"].array)!{
//                    sources.append(SourceObject(json: source))
//                }
//        }
//    }
}
