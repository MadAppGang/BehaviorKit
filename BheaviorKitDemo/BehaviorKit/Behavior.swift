//
//  Behavior.swift
//  BheaviorKitDemo
//
//  Created by Ievgen Rudenko on 02/07/15.
//  Copyright (c) 2015 MadAppGang. All rights reserved.
//

import UIKit

/// Base Behavior class, see documentation to understand, why it inherits from UIControl
class Behavior: UIControl {
    
 /// Optional owner if behavior object
    weak var owner:AnyObject? = nil
    
}
