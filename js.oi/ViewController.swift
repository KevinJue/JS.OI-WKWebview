//
//  ViewController.swift
//  js.oi
//
//  Created by Kevin Jue on 22/02/2015.
//  Copyright (c) 2015 Kevin Jue. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, UIWebViewDelegate, WKNavigationDelegate, WKUIDelegate {
    
    // MARK: Property
    private let singleton = Singleton.sharedInstance
    var webView: WebViewClass?

    
    // MARK: Life Circle
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        addObserverInView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check if WKWebView class
        if (NSClassFromString("WKWebView") != nil) {
            let w = WKWebView(delegateView: self)
            w.frame = self.view.frame
            self.webView = w
            self.view.addSubview(self.webView as WKWebView)
        } else {
            // fall back on UIWebView
            let w = UIWebView(delegateView: self)
            w.frame = self.view.frame
            self.webView = w
            self.view.addSubview(self.webView as UIWebView)
        }
        
        if let webViewUrl = NSUserDefaults.standardUserDefaults().objectForKey("webViewUrl") as? String {
            self.webView?.loadRequestFromString(webViewUrl)
            NSUserDefaults.standardUserDefaults().removeObjectForKey("webViewUrl")
        } else {
            self.webView?.loadRequestFromString("https://github.com/KevinJue/JS.OI-WKWebview/blob/master/README.md")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Notification center
    func addObserverInView(){
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "methodOfUpdateWebViewUrlFromNotification:",
            name:"updateWebviewFromNotificationUrl",
            object: nil
        )
    }
    
    func methodOfUpdateWebViewUrlFromNotification(notification: NSNotification){
        //Action take on Notification with url
        if let webViewUrl = NSUserDefaults.standardUserDefaults().objectForKey("webViewUrl") as? String {
            self.webView?.loadRequestFromString(webViewUrl)
            NSUserDefaults.standardUserDefaults().removeObjectForKey("webViewUrl")
        }
    }
    
    
}
