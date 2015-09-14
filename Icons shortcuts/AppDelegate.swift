//
//  AppDelegate.swift
//  Icons shortcuts
//
//  Created by Michal Stringcode on 14/09/2015.
//  Copyright © 2015 stringCode ltd. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    enum ShortcutType: String {
        case Torquiose = "reverse.domain.turquoise"
        case Red = "reverse.domain.red"
    }
    
    var window: UIWindow?

    static let applicationShortcutUserInfoIconKey = "applicationShortcutUserInfoIconKey"

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        var launchedFromShortCut = false
        //Check for ShortCutItem
        if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsShortcutItemKey] as? UIApplicationShortcutItem {
            launchedFromShortCut = true
            handleShortCutItem(shortcutItem)
        }
        
        //Return false incase application was lanched from shorcut to prevent
        //application(_:performActionForShortcutItem:completionHandler:) from being called
        return !launchedFromShortCut
    }

    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: Bool -> Void) {
        let handledShortCutItem = handleShortCutItem(shortcutItem)
        completionHandler(handledShortCutItem)
    }
    
    func handleShortCutItem(shortcutItem: UIApplicationShortcutItem) -> Bool {
        var handled = false
        //Get type string from shortcutItem
        if let shortcutType = ShortcutType.init(rawValue: shortcutItem.type) {
            //Get root navigation viewcontroller and its first controller
            let rootNavigationViewController = window!.rootViewController as? UINavigationController
            let rootViewController = rootNavigationViewController?.viewControllers.first as UIViewController?
            //Pop to root view controller so that approperiete segue can be performed
            rootNavigationViewController?.popToRootViewControllerAnimated(false)
            
            switch shortcutType {
            case .Torquiose:
                rootViewController?.performSegueWithIdentifier(toTurquoiseSeque, sender: nil)
                handled = true
            case.Red:
                rootViewController?.performSegueWithIdentifier(toRedSeque, sender: nil)
                handled = true
            }
        }
        return handled
    }


}

