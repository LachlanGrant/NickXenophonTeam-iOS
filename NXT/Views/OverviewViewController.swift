//
//  OverviewViewController.swift
//  NXT
//
//  Created by Lachlan Grant on 22/10/2015.
//  Copyright © 2015 Lachlan Grant. All rights reserved.
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
import SwiftyJSON

class OverviewViewController: UIViewController {
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.flatBlackColor()
        self.header.textColor = UIColor.flatOrangeColor();
        self.textView.textColor = UIColor.flatOrangeColor();
        
        checkVersion()
    }
    
    func checkVersion() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if (userDefaults.valueForKey("version") == nil) {
            //Never been opened
            let tutorial = getViewController("tutorial")
            self.frostedViewController.contentViewController = tutorial
        }
    }
    
    @IBAction func showMenu() {
        self.frostedViewController.presentMenuViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
