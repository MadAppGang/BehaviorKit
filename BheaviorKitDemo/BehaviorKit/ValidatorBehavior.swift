//
//  ValidatorBehavior.swift
//  BheaviorKitDemo
//
//  Created by Ievgen Rudenko on 12/08/15.
//  Copyright (c) 2015 MadAppGang. All rights reserved.
//

import UIKit


enum ValidatorBehaviorResult {
    case Valid
    case Invalid
    case CantValidate
}

class ValidatorBehavior: UIControl {

    /** Return true if value is valid. Otherwise NO. (read-only)*/
    private(set) var isValid = false
    
    /** validation result, count that there is nothing to validate **/
    internal(set) var validationResult:ValidatorBehaviorResult = .CantValidate {
        didSet {
            isValid = validationResult == .Valid
            self.sendActionsForControlEvents(.ValueChanged)
        }
    }
    
    
    @IBAction func forceValidation(sender: AnyObject) {
        //do nothing here
    }

}