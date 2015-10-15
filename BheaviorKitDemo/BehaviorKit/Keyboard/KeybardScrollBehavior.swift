//
//  KeybardScrollBehavior.swift
//  BheaviorKitDemo
//
//  Created by Ievgen Rudenko on 17/07/15.
//  Copyright (c) 2015 MadAppGang. All rights reserved.
//

import UIKit

class KeybardScrollBehavior: Behavior {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var mainView: UIView!
    
    @IBInspectable var scrollMargin: CGFloat = 0
    @IBInspectable var onlyScrollToTop: Bool = false
    

    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHide:", name: UIKeyboardDidHideNotification, object: nil)
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHide:", name: UIKeyboardDidHideNotification, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    func keyboardDidShow(notification: NSNotification) {
        if let responder = UIResponder.firstResponder as? UIView  where responder.isSubviewOf(superview:scrollView) {
            let globalY = responder.convertRect(responder.frame, toView: mainView).origin.y + responder.frame.size.height
            if let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue() {
                let keyboardFrameInView = mainView.convertRect(keyboardFrame, fromView: nil)
                let delta = (keyboardFrameInView.origin.y-scrollMargin) - globalY
                if !(delta>0 && onlyScrollToTop) {
                    let newOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y-delta)
                    scrollView.setContentOffset(newOffset, animated: true)
                }
            }
        }
    }

    func keyboardDidHide(notification: NSNotification) {
        //looks like we have do nothing
    }

    
}
