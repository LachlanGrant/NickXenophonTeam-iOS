//
//  Globals.swift
//  NXT
//
//  Created by Lachlan Grant on 22/10/2015.
//  Copyright © 2015 Lachlan Grant. All rights reserved.
//

import Foundation
import UIKit

func getViewController(id: String) -> UIViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    let viewcontroller = storyboard.instantiateViewControllerWithIdentifier(id)
    
    return viewcontroller
}