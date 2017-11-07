//
//  ArticleSourcesCollectionViewController.swift
//  WorldNews
//
//  Created by ba9nist on 07.11.17.
//  Copyright © 2017 ba9nist. All rights reserved.
//

import UIKit

class ArticleSourcesCollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    fileprivate let reuseIdentifier = "ArticleSourcesCollectionViewCell"
    fileprivate let cellHeight:CGFloat = 125
    fileprivate let itemsInRow: CGFloat = 2
    
    var sources: [SourceObject] = []
    var sourceToLoad: String?{
        didSet{
            self.loadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: "ArticleSourcesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        self.addLeftBarButtonWithImage(UIImage(named: "ic_menu_black_24dp")!)
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.addLeftGestures()
        
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData(){
        NewsApi.sharedInstance.getSources(type: sourceToLoad) {(newSources, error) in
            if(newSources == nil){
                print(error!.localizedDescription)
                return;
            }
            self.sources = newSources!
            self.collectionView.reloadData()
        }
    }


}

extension ArticleSourcesCollectionViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destination = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewsTableViewController") as! NewsTableViewController
        destination.sourceToLoad = sources[indexPath.row].source
        self.navigationController?.pushViewController(destination, animated: true)
    }
}

extension ArticleSourcesCollectionViewController : UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sources.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ArticleSourcesCollectionViewCell
        
        cell.setupData(sourceObject: sources[indexPath.row])
        return cell
    }
    
}

extension ArticleSourcesCollectionViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = 10 * (itemsInRow+1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsInRow
        
        return CGSize(width: widthPerItem, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
