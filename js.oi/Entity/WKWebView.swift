//
//  WebViewClass.swift
//  WKWebView class (extend WebViewClass)
//
//  Created by Kevin Jue on 08/02/2015.
//  Copyright (c) 2015 Jue Kevin. All rights reserved.
//

import UIKit
import WebKit

extension WKWebView: WebViewClass {
    
    // Use associated objects to set and get the request ivar
    func associatedObjectKey() -> String {
        return "kAssociatedObjectKey"
    }
    
    var request: NSURLRequest? {
        get {
            return objc_getAssociatedObject(self, associatedObjectKey()) as? NSURLRequest
        }
        set(newValue) {
            objc_setAssociatedObject(self, associatedObjectKey(), newValue, UInt(OBJC_ASSOCIATION_RETAIN_NONATOMIC))
        }
    }
    
    convenience init(delegateView: AnyObject) {
        self.init()
        self.UIDelegate = delegateView as? WKUIDelegate
        self.navigationDelegate = delegateView as? WKNavigationDelegate
    }
    
    func setDelegateViews(viewController: ViewController) {
        self.UIDelegate = viewController as WKUIDelegate
        self.navigationDelegate = viewController as WKNavigationDelegate
    }

    func getUrl() -> NSURL? {
        return self.request?.URL
    }
    
    func loadRequestFromString(urlNameAsString: String!) {
        self.loadRequest(NSURLRequest(URL: NSURL(string: urlNameAsString)!))
    }
    
    func evaluateJavaScriptInWebView(javascriptString: String!, completionHandler: (AnyObject, NSError) -> ()) {
        self.evaluateJavaScript(javascriptString, completionHandler: { (AnyObject, NSError) -> Void in
            
        })
    }
}

