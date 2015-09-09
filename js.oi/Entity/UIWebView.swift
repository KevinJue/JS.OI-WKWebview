//
//  WebViewClass.swift
//  UIWebView class (extend WebViewClass)
//
//  Created by Kevin Jue on 08/02/2015.
//  Copyright (c) 2015 Jue Kevin. All rights reserved.//

import UIKit

extension UIWebView: WebViewClass {
    
    // A simple convenience initializer, this allows for UIWebView(delegateView:) initialization
    convenience init(delegateView: UIWebViewDelegate) {
        self.init()
        self.delegate = delegateView
    }
    
    // UIWebView has one delegate method so this is pretty straight forward
    func setDelegateViews(viewController: ViewController) {
        delegate = viewController
    }
    
    // A quick method for loading requests based on strings in a URL format
    func loadRequestFromString(urlNameAsString: String!) {
        loadRequest(NSURLRequest(URL: NSURL(string: urlNameAsString)!))
    }
    
    func getUrl() -> NSURL? {
        return self.request?.URL
    }
    
    func evaluateJavaScriptInWebView(javascriptString: String!, completionHandler: (AnyObject, NSError) -> ()) {
        // Have the WebView evaluate the javascript string
        var string = stringByEvaluatingJavaScriptFromString(javascriptString)
        
        // Call the completion handler from there
        completionHandler(string!, NSError())
    }
    
    func setScalesPageToFit(setPages: Bool!) {
        self.scalesPageToFit = setPages
    }
    
}
