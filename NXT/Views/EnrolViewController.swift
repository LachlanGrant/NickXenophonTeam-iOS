//
//  EnrolViewController.swift
//  NXT
//
//  Created by Lachlan Grant on 26/10/2015.
//  Copyright © 2015 Lachlan Grant. All rights reserved.
//

import UIKit

class EnrolViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let webview = UIWebView(frame: view.bounds)
        webview.translatesAutoresizingMaskIntoConstraints = false
        
        let urlString = "http://www.aec.gov.au/enrol/"
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!)
        webview.loadRequest(request)
        
        
        self.view.addSubview(webview)
        
        self.view.addConstraint(NSLayoutConstraint(item: webview, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: webview, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: webview, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1.0, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: webview, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1.0, constant: 0.0))
        
        self.view.layoutIfNeeded()
    }
    @IBOutlet weak var openMenu: UIBarButtonItem!
    
    @IBAction func openMenuAction(sender: AnyObject) {
        self.frostedViewController.presentMenuViewController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
