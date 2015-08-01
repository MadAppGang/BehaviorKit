//
//  UIView.swift
//  BheaviorKitDemo
//
//  Created by Ievgen Rudenko on 01/08/15.
//  Copyright (c) 2015 MadAppGang. All rights reserved.
//

import UIKit

extension UIView {
    func isSubviewOf(superview aSuperview: UIView) -> Bool {
        if superview == aSuperview {
            //direct subview
            return true
        } else {
            if let superview = superview {
                //recoursive call up on hierarchy
                return superview.isSubviewOf(superview: aSuperview)
            } else {
                //the view is topmost in hierarchy, so there are no superview for it
                return false
            }
        }
    }
}
