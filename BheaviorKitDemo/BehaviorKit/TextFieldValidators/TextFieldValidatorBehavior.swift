//
//  TextFieldValidatorBehavior.swift
//  BheaviorKitDemo
//
//  Created by Ievgen Rudenko on 12/08/15.
//  Copyright (c) 2015 MadAppGang. All rights reserved.
//

import UIKit

class TextFieldValidatorBehavior: ValidatorBehavior {
    /** If defined field will be checked.
    Default set to nil. */
    @IBInspectable var regexpPattern:String? = nil {
        didSet {
            var options:NSRegularExpressionOptions  = NSRegularExpressionOptions(rawValue:0)
            if (!caseSensitive) {
                options = .CaseInsensitive;
            }
            regexp = nil
            if let regexpPattern = regexpPattern {
                do {
                    try regexp = NSRegularExpression(pattern: regexpPattern, options: options)
                } catch {
                    //nothing to do to recover
                }
            }
            forceValidation(self)
        }
    }

    //case sensitive validation, default is false
    @IBInspectable var caseSensitive: Bool = false {
        didSet {
            forceValidation(self)
        }
    }
    
    /** If set to NO text will be validated when editing is done.
    Default set to YES. */
    @IBInspectable var validateWhenType: Bool = true
    
    /** Field is validate when its value will be equal or longer than set number.
    If text is shorter than this value the field looks normal (both colors valid and invalid aren't apply).
    Default set to 1 (minimum value). */
    @IBInspectable var minimalNumberOfCharactersToStartValidation:Int = 1
    
    /**
    *  Text field to validate
    */
    @IBOutlet var textField:UITextField? = nil {
        didSet {
            if let textField = textField {
                textField.delegate = self
            }
        }
    }
    
    /**
    *  Resign textField as first responder, on "Enter" keyboard button pressed,
    *  has no effect, when nextTextField connected
    *  NO by default
    */
    @IBInspectable var hideKeyboardOnEnter: Bool = false
    
    /**
    *  If next text field connected, makes it first responder on "Enter" button press
    */
    @IBOutlet var nextTextField:UITextField! = nil

    
    /// Pruvate regexp property
    private var regexp:NSRegularExpression? = nil


    override func forceValidation(sender: AnyObject) {
        if let text = textField?.text {
                validateField(text)
        }
    }

}

//Private implementation
private extension TextFieldValidatorBehavior {
    private func validateField(text:String) {
        if text.characters.count < minimalNumberOfCharactersToStartValidation {
            self.validationResult = .CantValidate
        } else {
            if let _ = regexpPattern  {
                let textRange = NSMakeRange(0, text.characters.count)
                let matches = regexp!.matchesInString(text, options: [], range: textRange)
                
                var resultRange = NSMakeRange(NSNotFound, 0)
                if matches.count == 1 {
                    resultRange = matches[0].range
                }
                validationResult = NSEqualRanges(textRange, resultRange) ? .Valid : .Invalid
            } else {
                //if pattern is empty - always validated
                validationResult = .Valid
            }
        }
    }
}


extension TextFieldValidatorBehavior: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if let text = textField.text {
            validateField(text)
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if let text = textField.text {
            validateField(text)
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if validateWhenType {
            if let text = textField.text {
                let proposedNewString = (text as NSString).stringByReplacingCharactersInRange(range, withString:string)
                validateField(proposedNewString)
            }
        }
        return true
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        guard let text  = textField.text else { return true }
        validateField(text)
        if let nextTextField = nextTextField {
            nextTextField.becomeFirstResponder()
        } else if hideKeyboardOnEnter {
            textField.resignFirstResponder()
        }
        return true
    }
    
}
