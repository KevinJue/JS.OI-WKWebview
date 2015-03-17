//
//  AppDelegate.swift
//  js.oi
//
//  Created by Kevin Jue on 22/02/2015.
//  Copyright (c) 2015 Kevin Jue. All rights reserved.
//

import UIKit
import SystemConfiguration
import CoreTelephony


@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var helper: WebViewClass?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
        // Test user network connection
        var userConnected = true
        if(!isConnectedToNetwork()){
            userConnected = false
        }
        
        // Push notification configuration
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0
        if let remoteNotification = launchOptions?[UIApplicationLaunchOptionsRemoteNotificationKey] as? NSDictionary {
            application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes:
                UIUserNotificationType.Badge | UIUserNotificationType.Alert | UIUserNotificationType.Sound,
                categories: nil)
            )
            application.registerForRemoteNotifications()
            if  let urlRedirectionForWebView = remoteNotification["url"] as? String {
                NSUserDefaults.standardUserDefaults().setObject(urlRedirectionForWebView, forKey:"webViewUrl")
            }
        }
        
        NSUserDefaults.standardUserDefaults().setObject(userConnected, forKey:"isConnected")
        NSUserDefaults.standardUserDefaults().synchronize()
        return true
    }
    
    func application( application: UIApplication!, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData! ) {
        // Parse token to retrieve the string value
        var deviceTokenString: String = (deviceToken.description as NSString)
            .stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString:"<>"))
            .stringByReplacingOccurrencesOfString(" ",withString:"") as String
        }
    
    func application( application: UIApplication!, didFailToRegisterForRemoteNotificationsWithError error: NSError! ) {
            // Do nothink because user refuse to accepte push notification
    }
    
    func  application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        let state : UIApplicationState = UIApplication.sharedApplication().applicationState;
        if (state != UIApplicationState.Active) {
            // Application receive push notification in background
            // path to a redirection of webview must be outside apn object like this: 
            // {
            //  "aps": {
            //      "alert": "Hello, world!",
            //      "sound": "default"
            //  }
            //  "url": "https:// ..."
            // }
            if  let urlRedirectionForWebView = userInfo["url"] as? String {
                NSUserDefaults.standardUserDefaults().setObject(urlRedirectionForWebView, forKey:"webViewUrl")
            }
        } else {
            // Application receive push notification in foreground
        }
        NSUserDefaults.standardUserDefaults().synchronize()
        UIApplication.sharedApplication().applicationIconBadgeNumber = 0

    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
    // MARK: Connectivity
    func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
            SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0)).takeRetainedValue()
        }
        
        var flags: SCNetworkReachabilityFlags = 0
        if SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) == 0 {
            return false;
        }
        
        let isReachable = (flags & UInt32(kSCNetworkFlagsReachable)) != 0
        let isWWAN = (flags & UInt32(kSCNetworkReachabilityFlagsIsWWAN)) != 0
        
        if(isReachable || isWWAN){
            // Have connection
            if (isWWAN){
                // Setup the Network Info and create a CTCarrier object
                var networkInfo = CTTelephonyNetworkInfo()
                var carrier = networkInfo.subscriberCellularProvider
                
                // Get carrier name
                var carrierName = carrier.carrierName
            }
            
            return true
        }
        return false;
    }


}

