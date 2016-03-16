//
//  LocationsTableViewController.swift
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

class LocationsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    var tableData: [JSON] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.flatBlackColor()
        tableView.separatorStyle = .None
        
        updateData()
    }
    
    func updateData() {
        if NSUserDefaults.standardUserDefaults().boolForKey("savedLocations") {
            print("Loading existing data")
            let documentDirURL = try! NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true)
            
            let fileDestURL = documentDirURL.URLByAppendingPathComponent("cachedLoactions.json")
            
            let data = NSData(contentsOfURL: fileDestURL)
            
            let json = JSON(data: data!)
            
            let array = json.arrayValue
            
            
            tableData = array
            tableView.reloadData()
            
            PKHUD.sharedHUD.hide()
            
        } else {
            
            print("Generating Data")
            let path = NSBundle.mainBundle().pathForResource("locations", ofType: "json")
            let data = NSData(contentsOfFile: path!)
            
            
            let json = JSON(data: data!)
            
            let array = json.arrayValue
            
            var finalArray: [JSON] = []
            
            if (NSUserDefaults.standardUserDefaults().stringForKey("postcode") == nil) {
                //Present Tutorial
                let tutorial = getViewController("tutorial")
                
                self.frostedViewController.contentViewController = tutorial
            }
            
            for location in array {
                if location["PremisesPostCode"].stringValue == NSUserDefaults.standardUserDefaults().stringForKey("postcode") {
                    finalArray.append(location)
                }
            }
            
            tableData = finalArray
            tableView.reloadData()
            
            //Save Data
            
            let documentDirURL = try! NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true)
            
            let fileDestURL = documentDirURL.URLByAppendingPathComponent("cachedLoactions.json")
            
            try! finalArray.description.writeToURL(fileDestURL, atomically: false, encoding: NSUTF8StringEncoding)
            
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "savedLocations")
            
            PKHUD.sharedHUD.hide()
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = tableData[indexPath.row]
        
        let title = item["PremisesNm"].stringValue
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        
        cell?.textLabel?.text = title
        cell?.backgroundColor = UIColor.flatBlackColor()
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let location = tableData[indexPath.row]
        
        let detail: LocationDetailViewController = getViewController("detail") as! LocationDetailViewController
        detail.location = location
        
        self.navigationController?.pushViewController(detail, animated: true)
    }

    @IBAction func openMenu() {
        self.frostedViewController.presentMenuViewController()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dest = segue.destinationViewController as! LocationDetailViewController
        dest.location = 
        
    }
    
    //MARK: 3D Touch
//    @available(iOS 9.0, *)
//    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
//        let indexPath = tableView.indexPathForRowAtPoint(location)
//        
//        if let row: Int = indexPath!.row {
//            let item = tableData[row]
//            
//            let detailView = getViewController("detail") as! LocationDetailViewController
//            detailView.preferredContentSize = CGSize(width: 0, height: 400)
//            detailView.location = item
//            
//            let cell = tableView.indexPathForRowAtPoint(location)
//            
//            previewingContext.sourceRect = tableView.cellForRowAtIndexPath(cell!)!.frame
//            
//            return detailView
//        }
//        
//        
//    }
//    
//    @available(iOS 9, *)
//    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
//        self.navigationController?.pushViewController(viewControllerToCommit, animated: true)
//    }
}
