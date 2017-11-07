//
//  LeftMenuViewController.swift
//  WorldNews
//
//  Created by ba9nist on 06.11.17.
//  Copyright © 2017 ba9nist. All rights reserved.
//

import UIKit

enum LeftMenu1: Int {
    case main = 0
}

protocol LeftMenuProtocol1 : class {
    func changeViewController(_ menu: LeftMenu1)
}

struct Category{
    var name: String
    var image: UIImage
}
class LeftMenuViewController: UIViewController, LeftMenuProtocol1{
     @IBOutlet weak var tableView: UITableView!
//    var mainViewController: ArticleSourcesViewController! = nil
    var mainViewController: ArticleSourcesCollectionViewController! = nil
    
    let categories = [Category(name: "business", image: #imageLiteral(resourceName: "business")),
                      Category(name: "entertainment", image: #imageLiteral(resourceName: "entertainment")),
                      Category(name: "gaming", image: #imageLiteral(resourceName: "gaming")),
                      Category(name: "general", image: #imageLiteral(resourceName: "home")),
                      Category(name: "music", image: #imageLiteral(resourceName: "music")),
                      Category(name: "politics", image: #imageLiteral(resourceName: "politics")),
                      Category(name: "science-and-nature", image: #imageLiteral(resourceName: "science")),
                      Category(name: "sport", image: #imageLiteral(resourceName: "sport")),
                      Category(name: "technology", image: #imageLiteral(resourceName: "technology"))
                      ]
    
    fileprivate let reuseIdentifier = "LeftMenuTableViewCell"
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        mainViewController = storyboard.instantiateViewController(withIdentifier: "ArticleSourcesViewController") as! ArticleSourcesViewController
        
        
        tableView.register(UINib(nibName: "LeftMenuTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeViewController(_ menu: LeftMenu1) {
        switch menu {
        case .main:
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
//        case .swift:
//            self.slideMenuController()?.changeMainViewController(self.swiftViewController, close: true)
//        case .java:
//            self.slideMenuController()?.changeMainViewController(self.javaViewController, close: true)
//        case .go:
//            self.slideMenuController()?.changeMainViewController(self.goViewController, close: true)
//        case .nonMenu:
//            self.slideMenuController()?.changeMainViewController(self.nonMenuViewController, close: true)
        }
    }

}

extension LeftMenuViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! LeftMenuTableViewCell
        
        cell.setupData(name: categories[indexPath.row].name, image: categories[indexPath.row].image)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
}

extension LeftMenuViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainViewController.sourceToLoad = categories[indexPath.row].name
        //mainViewController.loadData()
        self.slideMenuController()?.closeLeft()
    }
}
