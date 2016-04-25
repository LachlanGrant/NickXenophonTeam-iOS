//
//  MenuTableViewController.swift
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

class MenuTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let viewID = getViewID(indexPath)
        presentView(viewID)
    }
    
    func getViewID(indexPath: NSIndexPath) -> String {
        
        switch indexPath.row {
        case 1:
            return "overview"
        case 2:
            return "locations"
        case 3:
            return "enrol"
        case 4:
            return "check"
        case 5:
            return "howtovote"
        case 6:
            return "policies"
        case 7:
            return "volunteer"
        default:
            return "error"
        }
    }
    
    func presentView(id: String) {
        if id == "locations" {
            PKHUD.sharedHUD.contentView = PKHUDTextView(text: "Loading...")
            PKHUD.sharedHUD.show()
        }
            let nextView = getViewController(id)
            
            self.frostedViewController.contentViewController = nextView
            self.frostedViewController.hideMenuViewController()
        
    }
}
