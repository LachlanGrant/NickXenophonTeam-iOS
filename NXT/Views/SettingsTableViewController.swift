//
//  SettingsTableViewController.swift
//  NXT
//
//  Created by Lachlan Grant on 26/10/2015.
//  Copyright © 2015 Lachlan Grant. All rights reserved.
//

import UIKit
import MessageUI
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
import FLEX

class SettingsTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    //MARK: Variables
    let items: [String] = ["Acknowledgements", "Change postcode", "Change State", "Reset User Data", "Debug - Beta Only!!", "Report an Issue"]

    @IBOutlet weak var footerLabel: UILabel!
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor.flatBlackColor()
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.footerLabel.textColor = UIColor.flatOrangeColor()
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            let ack = VTAcknowledgementsViewController(acknowledgementsPlistPath: NSBundle.mainBundle().pathForResource("Pods-acknowledgements", ofType: "plist"))
            ack!.headerText = "NXT for iOS uses the following 3rd party frameworks:"
            
            ack?.footerText = "Copyright (c) 2013-2015 Lachlan Grant. All rights reserved."
            self.navigationController?.pushViewController(ack!, animated: true)
            
        case 1:
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "savedLocations")
            let alert = UIAlertController(title: "Enter your postcode:", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addTextFieldWithConfigurationHandler { (textfield) -> Void in
                textfield.keyboardType = UIKeyboardType.NumberPad
                textfield.autocorrectionType = UITextAutocorrectionType.No
            }
            
            alert.addAction(UIAlertAction(title: "Save", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                let textfield = alert.textFields?.first
                
                if let postcode = textfield?.text {
                    NSUserDefaults.standardUserDefaults().setObject(postcode, forKey: "postcode")
                } else {
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            }))
            
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Destructive, handler: { (action) -> Void in
                alert.removeFromParentViewController()
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        case 2:
            let states: [String] = ["ACT", "NSW", "QLD", "SA", "TAS", "WA"]
            
            ActionSheetStringPicker.showPickerWithTitle("Select your state:", rows: states, initialSelection: 2, doneBlock: { (picker, value, index) -> Void in
                //
                NSUserDefaults.standardUserDefaults().setObject(index, forKey: "state")
                }, cancelBlock: { ActionStringCancelBlock in return } , origin: self.view)
            
        case 3:
            NSUserDefaults.standardUserDefaults().removeObjectForKey("savedLocations")
            NSUserDefaults.standardUserDefaults().removeObjectForKey("postcode")
            NSUserDefaults.standardUserDefaults().removeObjectForKey("state")
            NSUserDefaults.standardUserDefaults().removeObjectForKey("version")
            
            let alert = UIAlertController(title: "Please relaunch NXT for your changes to take effect", message: nil, preferredStyle: .Alert)
            
            alert.addAction(UIAlertAction(title: "Relaunch", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                exit(1)
            }))
            presentViewController(alert, animated: true, completion: nil)
            
        case 4:
            FLEXManager.sharedManager().showExplorer()
            
        case 5:
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                mail.mailComposeDelegate = self
                mail.setSubject("[NXT][Bug]")
                mail.setMessageBody("Issue I have found is: ", isHTML: false)
                mail.setToRecipients(["lachy.g572@me.com"])
                
                presentViewController(mail, animated: true, completion: nil)
            }
            
        default:
            break
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        
        cell?.textLabel?.text = items[indexPath.row]
        cell?.textLabel?.textColor = UIColor.flatOrangeColor()
        cell?.backgroundColor = UIColor.flatBlackColor()
        
        return cell!
    }

    //MARK: IBAction
    @IBAction func openMenu(sender: AnyObject) {
        self.frostedViewController.presentMenuViewController()
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch result {
        case MFMailComposeResultCancelled, MFMailComposeResultFailed, MFMailComposeResultSaved:
            controller.dismissViewControllerAnimated(true, completion: nil)
            break
            
        case MFMailComposeResultSent:
            controller.dismissViewControllerAnimated(true, completion: nil)
            let alert = UIAlertController(title: "Thanks for reporting your issue!", message: nil, preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Close", style: .Default, handler: { (action) -> Void in
                alert.removeFromParentViewController()
            }))
            
            presentViewController(alert, animated: true, completion: nil)
            break
            
        default:
            break
        }
    }
}
