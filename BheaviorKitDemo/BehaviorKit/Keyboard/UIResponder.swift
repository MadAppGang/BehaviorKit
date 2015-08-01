//
//  UIResponder.swift
//  BheaviorKitDemo
//
//  Created by Ievgen Rudenko on 01/08/15.
//  Copyright (c) 2015 MadAppGang. All rights reserved.
//

import UIKit




extension UIResponder {
    
//    static var currentFirstResponder:UIResponder? = nil //fires: A declaration cannot be both 'final' and 'dynamic'
    
    class var firstResponder:UIResponder? {
        UIResponderStorage.currentFirstResponder = nil
        UIApplication.sharedApplication().sendAction("findFirstResponder:", to: nil, from: nil, forEvent: nil)
        return UIResponderStorage.currentFirstResponder
    }

    func findFirstResponder(sender:AnyObject?) {
        UIResponderStorage.currentFirstResponder = self
    }
    
}

// because static var currentFirstResponder:UIResponder? = nil is not working
// and class var currentFirstResponder:UIResponder? = nil is not supported yet
struct UIResponderStorage {
    static var currentFirstResponder:UIResponder? = nil
}