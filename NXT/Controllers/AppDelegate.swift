//
//  AppDelegate.swift
//  NXT
//
//  Created by Lachlan Grant on 10/21/15
//  Copyright (c) 2015 Lachlan Grant. All rights reserved.
//

import UIKit
import ChameleonFramework
import FlatUIKit
import VTAcknowledgementsViewController
import JSPatch
import CBZSplashView
import Shimmer
import ActionSheetPicker_3_0
import PKHUD
import SCLAlertView
import REFrostedViewController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var frostedViewController: REFrostedViewController?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window?.backgroundColor = .whiteColor()
        self.window?.makeKeyAndVisible()
        
        let overview = getViewController("overview")
        
        let icon = UIImage(named: "Icon_Small")
        let splashView = CBZSplashView(icon: icon, backgroundColor: UIColor.flatBlackColor())
        splashView.animationDuration = 2.5
        splashView.iconColor = UIColor.flatOrangeColor()
        
        let menu = getViewController("menu")
        
        frostedViewController = REFrostedViewController(contentViewController: overview, menuViewController: menu)
        frostedViewController?.direction = REFrostedViewControllerDirection.Left
        frostedViewController?.liveBlur = false
        frostedViewController?.blurTintColor = UIColor.flatOrangeColor()
        frostedViewController?.limitMenuViewSize = true
        
        self.window?.rootViewController = frostedViewController
        
        self.window?.rootViewController!.view.addSubview(splashView)
        splashView.startAnimation()
        
        changeAppearance()
        
        if #available(iOS 9.0, *) {
            if let shortcutItem = launchOptions?[UIApplicationLaunchOptionsShortcutItemKey] as? UIApplicationShortcutItem {
                handleShortcut(shortcutItem)
            }
        } else {
            // Fallback on earlier versions
        }
        print(NSBundle.mainBundle().infoDictionary!["CFBundleVersion"])
        print(NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"])
        
        return true
    }
    
    func changeAppearance() {
        UINavigationBar.appearance().barTintColor = UIColor.flatOrangeColor()
        UINavigationBar.appearance().barStyle = UIBarStyle.Default
        UIWindow.appearance().tintColor = .flatBlackColor()
        UINavigationBar.appearance().translucent = false
        UIToolbar.appearance().barStyle = .Black
        UIToolbar.appearance().tintColor = .flatOrangeColor()
        UITableViewCell.appearance().backgroundColor = .flatOrangeColor()
        UIImageView.appearance().tintColor = .flatOrangeColor()
    }
    
    
    @available(iOS 9.0, *)
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        handleShortcut(shortcutItem)
    }
    
    @available(iOS 9.0, *)
    func handleShortcut(shortcutItem: UIApplicationShortcutItem) {
        if shortcutItem.type == "com.lachlangrant.NXT.locations" {
            self.frostedViewController?.contentViewController = getViewController("locations")
        } else if shortcutItem.type == "com.lachlangrant.NXT.howtovote" {
            self.frostedViewController?.contentViewController = getViewController("howtovote")
        }
    }
}
