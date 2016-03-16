//
//  PoliciesViewController.swift
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

class PoliciesViewController: UITableViewController {

    @IBOutlet weak var cell1: UITableViewCell!
    @IBOutlet weak var cell2: UITableViewCell!
    @IBOutlet weak var cell3: UITableViewCell!
    @IBOutlet weak var cell4: UITableViewCell!
    @IBOutlet weak var cell5: UITableViewCell!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let cells : [UITableViewCell] = [cell1, cell2, cell3, cell4, cell5]
        
        for cell in cells {
            cell.backgroundColor = UIColor.flatBlackColor()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showMenu(sender: AnyObject) {
        self.frostedViewController.presentMenuViewController()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
