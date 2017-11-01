//
//  NewsTableViewController.swift
//  WorldNews
//
//  Created by ba9nist on 31.10.17.
//  Copyright © 2017 ba9nist. All rights reserved.
//

import UIKit
import Alamofire

class NewsTableViewController: UITableViewController {
    @IBOutlet weak var newsTableView: UITableView!
    
    var articles:[Article] = []
    
    let reuseIdentifier = "NewsTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NewsApi.sharedInstance.getAricles { (newArticles, error) in
            if(newArticles == nil){
                return
            }
            print("data arrives")
            self.articles = newArticles!
            self.newsTableView.reloadData()
        };
        
        newsTableView.register(UINib(nibName: "NewsTableViewCell", bundle:nil), forCellReuseIdentifier: reuseIdentifier)
        newsTableView.tableFooterView = UIView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NewsTableViewCell
        let article = articles[indexPath.row]
        cell.setupData(url: article.imageUrl!, title: article.title!, description: article.about!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIApplication.shared.open(URL(string: articles[indexPath.row].url!)!, options: [:], completionHandler:nil)
    }

}
