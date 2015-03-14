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
    
    private let singleton = Singleton.sharedInstance
    
    var webView: WebViewClass?

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
        
        self.webView?.loadRequestFromString("https://github.com/KevinJue/JS.OI-WKWebview/blob/master/README.md")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
