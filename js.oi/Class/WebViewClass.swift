//
//  WebViewClass.swift
//  Webview class
//
//  Created by Kevin Jue on 08/02/2015.
//  Copyright (c) 2015 Jue Kevin. All rights reserved.//

import Foundation

protocol WebViewClass: class {

    func setDelegateViews(viewController: ViewController)
    
    var request: NSURLRequest? { get }
    
    func URL() -> NSURL?
    
    func loadRequestFromString(urlNameAsString: String!)
    
    
    func evaluateJavaScript(javascriptString: String!, completionHandler: (AnyObject, NSError) -> ())
}