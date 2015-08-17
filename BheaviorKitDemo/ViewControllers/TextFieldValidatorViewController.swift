//
//  TextFieldValidatorViewController.swift
//  BheaviorKitDemo
//
//  Created by Ievgen Rudenko on 17/08/15.
//  Copyright (c) 2015 MadAppGang. All rights reserved.
//

import UIKit

class TextFieldValidatorViewController: UIViewController {
    
    @IBOutlet weak var numberValidationResult: UILabel!
    @IBOutlet weak var emailValidationResult: UILabel!
    @IBOutlet weak var charsValidationResult: UILabel!
    
    
    @IBAction func numberValidation(sender: TextFieldValidatorBehavior) {
        numberValidationResult.text = sender.isValid == true ? "Valid" : "Invalid"
    }
    
    @IBAction func emailValidation(sender: TextFieldValidatorBehavior) {
        emailValidationResult.text = sender.isValid == true ? "Valid" : "Invalid"
    }
    
    @IBAction func charsValidation(sender: TextFieldValidatorBehavior) {
        charsValidationResult.text = sender.isValid == true ? "Valid" : "Invalid"
    }
    
}