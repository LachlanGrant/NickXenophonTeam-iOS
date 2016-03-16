//
//  LocationDetailViewController.swift
//  NXT
//
//  Created by Lachlan Grant on 22/10/2015.
//  Copyright © 2015 Lachlan Grant. All rights reserved.
//

import UIKit
import MapKit
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

class LocationDetailViewController: UIViewController {
    var location: JSON?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var suburbLabel: UILabel!
    @IBOutlet weak var seatLabel: UILabel!
    
    @IBOutlet weak var locationTitle: UILabel!
    @IBOutlet weak var addressTitle: UILabel!
    @IBOutlet weak var suburbTitle: UILabel!
    @IBOutlet weak var seatTitle: UILabel!
    
    @IBOutlet weak var viewMapButton: FUIButton!
    @IBOutlet weak var directionsButton: FUIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let loc = location {
            nameLabel.text = loc["PremisesNm"].stringValue
            addressLabel.text = loc["PremisesAddress1"].stringValue
            suburbLabel.text = loc["PremisesSuburb"].stringValue
            seatLabel.text = loc["DivisionNm"].stringValue
            
            navigationItem.title = loc["PremisesNm"].stringValue
        }
        
        let labelArray: [UILabel] = [nameLabel, addressLabel, suburbLabel, seatLabel, locationTitle, addressTitle, suburbTitle, seatTitle]
        
        for label in labelArray {
            label.textColor = UIColor.flatOrangeColor()
        }
        
        self.view.backgroundColor = UIColor.flatBlackColor()
        
        self.viewMapButton.buttonColor = UIColor.flatOrangeColor()
        self.viewMapButton.shadowColor = UIColor.flatOrangeColorDark()
        self.viewMapButton.setTitleColor(UIColor.cloudsColor(), forState: UIControlState.Normal)
        self.viewMapButton.shadowHeight = 3.0
        self.viewMapButton.cornerRadius = 6.0
        
        self.directionsButton.buttonColor = UIColor.flatOrangeColor()
        self.directionsButton.shadowColor = UIColor.flatOrangeColorDark()
        self.directionsButton.setTitleColor(UIColor.cloudsColor(), forState: UIControlState.Normal)
        self.directionsButton.shadowHeight = 3.0
        self.directionsButton.cornerRadius = 6.0
        
    }
    
    @IBAction func viewMapAction() {
        if let loc = location {
            let latitude = loc["Latitude"].doubleValue
            let longitude = loc["Longitude"].doubleValue
            
            let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
            
            let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
            
            let mapItem = MKMapItem(placemark: placemark)
            
            mapItem.name = loc["PremisesNm"].stringValue
            
            mapItem.openInMapsWithLaunchOptions(nil)
        }
    }
    
    @IBAction func getDirections() {
        if let loc = location {
            let latitude = loc["Latitude"].doubleValue
            let longitude = loc["Longitude"].doubleValue
            
            let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
            
            let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
            
            let mapItem = MKMapItem(placemark: placemark)
            
            mapItem.name = loc["PremisesNm"].stringValue
            
            let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            
            mapItem.openInMapsWithLaunchOptions(launchOptions)
        }
    }

}
