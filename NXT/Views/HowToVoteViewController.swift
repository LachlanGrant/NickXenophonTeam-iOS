//
//  HowToVoteViewController.swift
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

class HowToVoteViewController: UIViewController {
    @IBOutlet weak var senateButton: FUIButton!
    @IBOutlet weak var houseButton: FUIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.senateButton.buttonColor = UIColor.flatOrangeColor()
        self.senateButton.shadowColor = UIColor.flatOrangeColorDark()
        self.senateButton.setTitleColor(UIColor.cloudsColor(), forState: UIControlState.Normal)
        self.senateButton.shadowHeight = 3.0
        self.senateButton.cornerRadius = 6.0
        
        self.houseButton.buttonColor = UIColor.flatOrangeColor()
        self.houseButton.shadowColor = UIColor.flatOrangeColorDark()
        self.houseButton.setTitleColor(UIColor.cloudsColor(), forState: UIControlState.Normal)
        self.houseButton.shadowHeight = 3.0
        self.houseButton.cornerRadius = 6.0
        
        self.view.backgroundColor = UIColor.flatBlackColor()
    }
    
    @IBAction func senateAction(sender: AnyObject) {
        let senateView = SenateVoteCardViewController()
        self.navigationController?.pushViewController(senateView, animated: true)
    }
    
    @IBAction func houseAction(sender: AnyObject) {
        let houseView = HouseVoteCardViewController()
        self.navigationController?.pushViewController(houseView, animated: true)
    }
    
    @IBAction func openMenu(sender: AnyObject) {
        self.frostedViewController.presentMenuViewController()
    }
}
