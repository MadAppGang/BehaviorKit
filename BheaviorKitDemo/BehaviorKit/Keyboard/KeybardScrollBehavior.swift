//
//  KeybardScrollBehavior.swift
//  BheaviorKitDemo
//
//  Created by Ievgen Rudenko on 17/07/15.
//  Copyright (c) 2015 Meander Inc.. All rights reserved.
//

import UIKit

class KeybardScrollBehavior: Behavior {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var mainView: UIView!
    
    @IBInspectable var scrollMargin: CGFloat = 0
    @IBInspectable var onlyScrollToTop: Bool = false
    @IBInspectable var adjustBottomInset: Bool = false
    
    
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
        guard let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue() else {
            return
        }
        if let responder = UIResponder.firstResponder as? UIView  where responder.isSubviewOf(superview:scrollView) {
            var globalY = mainView.convertPoint(responder.frame.origin, fromView: scrollView).y
            globalY    += responder.frame.size.height

                let keyboardFrameInView = mainView.convertRect(keyboardFrame, fromView: nil)
                let delta = (keyboardFrameInView.origin.y-scrollMargin) - globalY
                if !(delta>0 && onlyScrollToTop) {
                    let newOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y-delta)
                    scrollView.setContentOffset(newOffset, animated: true)
                }
                if adjustBottomInset == true {
                    delay(0.1)  { [weak self] in self?.scrollView.contentInset.bottom = keyboardFrame.size.height }
                }
                
        } else  {
            if adjustBottomInset == true {
                delay(0.1)  { [weak self] in self?.scrollView.contentInset.bottom = keyboardFrame.size.height }
            }
        }
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }

    func keyboardDidHide(notification: NSNotification) {
        if adjustBottomInset == true {
            scrollView.contentInset.bottom = 0
        }
    }

    
}
