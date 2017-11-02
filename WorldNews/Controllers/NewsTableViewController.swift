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
    
    var sourceToLoad: String = ""
    var articles:[Article] = []
    let reuseIdentifier = "NewsTableViewCell"
    
    
    func createAlertView(msg: String){
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func loadArticles(){
        NewsApi.sharedInstance.getAricles(source: sourceToLoad) { (newArticles, error) in
            if(newArticles == nil){
                self.newsTableView.refreshControl?.endRefreshing()
                self.createAlertView(msg: error!.localizedDescription)
                return
            }
            print("data arrives")
            self.articles = newArticles!
            self.newsTableView.refreshControl?.endRefreshing()
            self.newsTableView.reloadData()
        };
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadArticles()
        
        newsTableView.register(UINib(nibName: "NewsTableViewCell", bundle:nil), forCellReuseIdentifier: reuseIdentifier)
        newsTableView.tableFooterView = UIView()
        
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NewsTableViewController.refresh(_:)), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.backgroundColor = UIColor.init(colorLiteralRed: 0.83, green: 0.83, blue: 0.83, alpha: 1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching data...")
        newsTableView.refreshControl = refreshControl
    }
    
    func refresh(_ refreshControl: UIRefreshControl) {
         print("refresh")
        newsTableView.refreshControl?.beginRefreshing()
        loadArticles()
       
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
        //UIApplication.shared.open(URL(string: articles[indexPath.row].url!)!, options: [:], completionHandler:nil)
        let destination = navigationController?.storyboard?.instantiateViewController(withIdentifier: "FullArticleViewController") as! FullArticleViewController
        destination.urlToLoad = articles[indexPath.row].url
        destination.author = articles[indexPath.row].author
        navigationController?.pushViewController(destination, animated: true)

    }

}
