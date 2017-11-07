//
//  ArticleSourcesViewController.swift
//  WorldNews
//
//  Created by ba9nist on 01.11.17.
//  Copyright © 2017 ba9nist. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class ArticleSourcesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var sourcesTableView: UITableView!
    
    @IBOutlet weak var placeholder: UILabel!
    let reuseIdentifier = "ArticleSourcesTableViewCell"
    
    var sourceToLoad: String?{
        didSet{
            print("didset")
            self.loadData()

        }
    }
    
    var sources: [SourceObject] = []
    
    func checkPlaceholder(){
        if(self.sources.count == 0){
            self.placeholder.isHidden = false
        }else{
            self.placeholder.isHidden = true
        }
    }
    
    func createAlertView(msg: String){
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
       
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func loadData(){
        checkPlaceholder()
        NewsApi.sharedInstance.getSources(type: sourceToLoad) {(newSources, error) in
            if(newSources == nil){
                print(error!.localizedDescription)
                self.sourcesTableView.refreshControl?.endRefreshing()
                self.createAlertView(msg: error!.localizedDescription)
                return;
            }
            self.sources = newSources!
            self.checkPlaceholder()
//            UIView.transition(with: self.sourcesTableView,
//                              duration: 0.5,
//                              options: .transitionCrossDissolve,
//                              animations: { self.sourcesTableView.reloadData() })
            self.sourcesTableView.reloadData()
            self.sourcesTableView.refreshControl?.endRefreshing()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.addLeftBarButtonWithImage(UIImage(named: "ic_menu_black_24dp")!)
        self.addRightBarButtonWithImage(UIImage(named: "ic_notifications_black_24dp")!)
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.removeRightGestures()
        self.slideMenuController()?.addLeftGestures()
        self.slideMenuController()?.addRightGestures()
        
        // Do any additional setup after loading the view.
        sourcesTableView.register(UINib(nibName: "ArticleSourcesTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        sourcesTableView.tableFooterView = UIView()
        loadData()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NewsTableViewController.refresh(_:)), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching data...")
        refreshControl.backgroundColor = UIColor.init(colorLiteralRed: 0.83, green: 0.83, blue: 0.83, alpha: 1.0)
        sourcesTableView.refreshControl = refreshControl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let indexPath = sourcesTableView.indexPathForSelectedRow else{
            print("no currently selected rows")
            return
        }
        sourcesTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func refresh(_ refreshControl: UIRefreshControl) {
        sourcesTableView.refreshControl?.beginRefreshing()
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - tableView dataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sources.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ArticleSourcesTableViewCell
        cell.setupData(sourceObject: sources[indexPath.row])
        return cell
    }
    
    //MARK: - tableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let destination = navigationController?.storyboard?.instantiateViewController(withIdentifier: "NewsTableViewController") as! NewsTableViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destination = storyboard.instantiateViewController(withIdentifier: "NewsTableViewController") as! NewsTableViewController
        destination.sourceToLoad = sources[indexPath.row].source
        self.navigationController?.pushViewController(destination, animated: true)
    }
    
}

extension ArticleSourcesViewController : SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
    func rightWillOpen() {
        print("SlideMenuControllerDelegate: rightWillOpen")
    }
    
    func rightDidOpen() {
        print("SlideMenuControllerDelegate: rightDidOpen")
    }
    
    func rightWillClose() {
        print("SlideMenuControllerDelegate: rightWillClose")
    }
    
    func rightDidClose() {
        print("SlideMenuControllerDelegate: rightDidClose")
    }
}
