//
//  FullArticleViewController.swift
//  WorldNews
//
//  Created by ba9nist on 02.11.17.
//  Copyright © 2017 ba9nist. All rights reserved.
//

import UIKit
import WebKit

class FullArticleViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var reloadDataButton: UIButton!
    var request: URLRequest!
    
    private var _urlToLoad:String = ""
    var urlToLoad: String{
        get{
            return self._urlToLoad
        }
        set{
            self._urlToLoad = newValue
            self.request = URLRequest(url: URL(string: _urlToLoad)!)
        }
    }
    
    var author = "No Title"
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        
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
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
        if(webView.url == nil){
            reloadDataButton.isHidden = false
            
        }
        
        createAlertView(msg: error.localizedDescription)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        if(webView.url == nil){
            reloadDataButton.isHidden = false

        }
        createAlertView(msg: error.localizedDescription)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        reloadDataButton.isHidden = true
    }
    
    func createAlertView(msg: String){
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func reloadData(_ sender: UIButton) {
        webView.load(self.request)
    }

}
