//
//  WebViewViewController.swift
//  NXT
//
//  Created by Lachlan Grant on 22/10/2015.
//  Copyright © 2015 Lachlan Grant. All rights reserved.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {
    @IBOutlet var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func loadPage(url: String) {
        let URL = NSURL(string: url)
        let request = NSURLRequest(URL: URL!)
        
        webView.loadRequest(request)
    }
    
    func loadFile(url: String) {
        let URL = NSURL(fileURLWithPath: url)
        let request = NSURLRequest(URL: URL)
        webView.loadRequest(request)
    }
    
    func overrideOpenMenuButton() {
        self.navigationItem.leftBarButtonItems = []
    }

    @IBAction func openMenu(sender: AnyObject) {
        self.frostedViewController.presentMenuViewController()
    }
}
