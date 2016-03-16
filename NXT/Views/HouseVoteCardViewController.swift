//
//  HouseVoteCardViewController.swift
//  NXT
//
//  Created by Lachlan Grant on 25/10/2015.
//  Copyright © 2015 Lachlan Grant. All rights reserved.
//

import UIKit

class HouseVoteCardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let webview = UIWebView(frame: view.bounds)
        webview.translatesAutoresizingMaskIntoConstraints = false
        
        let urlString = "http://blatdev.co/resources/NXT/house.pdf"
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
