//
//  FullArticleViewController.swift
//  WorldNews
//
//  Created by ba9nist on 02.11.17.
//  Copyright © 2017 ba9nist. All rights reserved.
//

import UIKit
import WebKit

class FullArticleViewController: UIViewController, WKUIDelegate {

    var webView: WKWebView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var urlToLoad = ""
    var author = ""
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = author
        
        view.insertSubview(webView, belowSubview: progressBar)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        let height = NSLayoutConstraint(item: webView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: webView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0)
        view.addConstraints([height, width])
        
        
        let url = URL(string: urlToLoad)
        let request = URLRequest(url: url!)
               webView.load(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            if(webView.estimatedProgress == 1.0){
                progressBar.isHidden = true
            }else{
                progressBar.isHidden = false
            }
            progressBar.progress = Float(webView.estimatedProgress)
        }
    }

}
