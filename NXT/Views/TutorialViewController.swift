//
//  TutorialViewController.swift
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

class TutorialViewController: UIViewController {
    var hasStateBeenSelected = false
    var hasPostCodeBeenEntered = false

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var beginLabel: UILabel!
    
    @IBOutlet weak var selectSateButton: FUIButton!
    @IBOutlet weak var enterPostCodeButton: FUIButton!
    @IBOutlet weak var doneButton: FUIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectSateButton.buttonColor = UIColor.flatOrangeColor()
        self.selectSateButton.shadowColor = UIColor.flatOrangeColorDark()
        self.selectSateButton.setTitleColor(UIColor.cloudsColor(), forState: UIControlState.Normal)
        self.selectSateButton.shadowHeight = 3.0
        self.selectSateButton.cornerRadius = 6.0
        
        self.enterPostCodeButton.buttonColor = UIColor.flatOrangeColor()
        self.enterPostCodeButton.shadowColor = UIColor.flatOrangeColorDark()
        self.enterPostCodeButton.setTitleColor(UIColor.cloudsColor(), forState: .Normal)
        self.enterPostCodeButton.shadowHeight = 3.0
        self.enterPostCodeButton.cornerRadius = 6.0
        
        self.doneButton.buttonColor = UIColor.flatOrangeColor()
        self.doneButton.shadowColor = UIColor.flatOrangeColorDark()
        self.doneButton.setTitleColor(UIColor.cloudsColor(), forState: .Normal)
        self.doneButton.shadowHeight = 3.0
        self.doneButton.cornerRadius = 6.0
        self.doneButton.enabled = false
        
        self.view.backgroundColor = UIColor.flatBlackColor()
        
        self.welcomeLabel.textColor = UIColor.cloudsColor()
        self.beginLabel.textColor = UIColor.cloudsColor()
    }
    
    @IBAction func stateAction(sender: AnyObject) {
        let states: [String] = ["ACT", "NSW", "QLD", "SA", "TAS", "WA"]
        
        ActionSheetStringPicker.showPickerWithTitle("Select your state", rows: states, initialSelection: 1, doneBlock: {
            picker, value, index in
            
            NSUserDefaults.standardUserDefaults().setObject(index, forKey: "state")
            self.hasStateBeenSelected = true
            self.checkButtonStatus()
            return
            }, cancelBlock: { ActionStringCancelBlock in return }, origin: sender)
    }
    
    @IBAction func postCodeAction(sender: AnyObject) {
        let alert = UIAlertController(title: "Enter your postcode:", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addTextFieldWithConfigurationHandler { (textfield) -> Void in
            textfield.keyboardType = UIKeyboardType.NumberPad
            textfield.autocorrectionType = UITextAutocorrectionType.No
        }
        
        alert.addAction(UIAlertAction(title: "Save", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            let textfield = alert.textFields?.first
            
            if let postcode = textfield?.text {
                NSUserDefaults.standardUserDefaults().setObject(postcode, forKey: "postcode")
                self.hasPostCodeBeenEntered = true
                self.checkButtonStatus()
            } else {
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.Destructive, handler: { (action) -> Void in
            alert.removeFromParentViewController()
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func checkButtonStatus() {
        if hasStateBeenSelected == true {
            selectSateButton.enabled = false
        }
        
        if hasPostCodeBeenEntered == true {
            enterPostCodeButton.enabled = false
        }
        
        if hasPostCodeBeenEntered && hasStateBeenSelected {
            NSUserDefaults.standardUserDefaults().setObject(NSBundle.mainBundle().infoDictionary!["CFBundleVersion"], forKey: "version")
            doneButton.enabled = true
        }
    }
    
    @IBAction func doneAction(sender: AnyObject) {
        self.frostedViewController.contentViewController = getViewController("overview")
    }
/*
    - (IBAction)selectState:(id)sender {
    NSArray *states = @[ @"ACT", @"NSW", @"NT", @"QLD", @"SA", @"TAS", @"WA"];
    
    MKActionSheet *action = [[MKActionSheet alloc] initWithTitle:@"Select your state:" dismissButtonTitle:@"Close" otherButtonTitles:states dismissOnSelect:TRUE];
    
    [action showInViewController:self withMKActionSheetBlock:^(NSInteger buttonIndex, BOOL isCancel) {
    NSLog(@"%@", states[buttonIndex]);
    [[NSUserDefaults standardUserDefaults] setObject:states[buttonIndex] forKey:@"state"];
    self.selectStateButton.enabled = FALSE;
    self.hasStateBeenSelected = true;
    [self checkDoneButton];
    }];
    }
    
    - (IBAction)enterPostCode:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Enter your postcode" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
    textField.keyboardAppearance = UIKeyboardAppearanceDark;
    textField.keyboardType = UIKeyboardTypeNumberPad;
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    if (alert.textFields.firstObject.text != nil) {
    [[NSUserDefaults standardUserDefaults] setObject:alert.textFields.firstObject.text forKey:@"postcode"];
    self.hasPostcodeBeenEntered = true;
    self.enterPostcodeButton.enabled = FALSE;
    [self checkDoneButton];
    }
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
    [alert removeFromParentViewController];
    }]];
    
    [self presentViewController:alert animated:true completion:nil];
    }
    
    -(void) checkDoneButton {
    if (self.hasStateBeenSelected && self.hasPostcodeBeenEntered) {
    doneButtom.enabled = true;
    }
    }
    
    - (IBAction)doneAction:(id)sender {
    [[NSUserDefaults standardUserDefaults] setFloat:[[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] floatValue] forKey:@"version"];
    [self dismissViewControllerAnimated:true completion:nil];
    }


*/
}
