//
//  ArticleSourcesViewController.swift
//  WorldNews
//
//  Created by ba9nist on 01.11.17.
//  Copyright © 2017 ba9nist. All rights reserved.
//

import UIKit

class ArticleSourcesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var sourcesTableView: UITableView!
    
    let reuseIdentifier = "ArticleSourcesTableViewCell"
    
    var sources: [SourceObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sourcesTableView.register(UINib(nibName: "ArticleSourcesTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        sourcesTableView.tableFooterView = UIView()
        
        NewsApi.sharedInstance.getSources { (newSources, error) in
            print("got result")
            if(newSources == nil){
                print(error.debugDescription)
            }
            self.sources = newSources!
            self.sourcesTableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - dataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sources.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = navigationController?.storyboard?.instantiateViewController(withIdentifier: "NewsTableViewController") as! NewsTableViewController
        destination.sourceToLoad = sources[indexPath.row].source
        navigationController?.pushViewController(destination, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ArticleSourcesTableViewCell
        cell.setupData(sourceObject: sources[indexPath.row])
        return cell
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
