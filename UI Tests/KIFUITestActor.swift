//
//  KIFUITestActor.swift
//  BheaviorKitDemo
//
//  Created by Ievgen Rudenko on 17/07/15.
//  Copyright (c) 2015 MadAppGang. All rights reserved.
//

import Foundation


extension KIFUITestActor {
    func choosePhotoInLibrary(row:Int, column:Int) {
        let headerHeight:CGFloat = 64.0;
        let thumbnailSize:CGSize = CGSize(width: 75.0, height: 75.0);
        let thumbnailMargin:CGFloat = 64.0;
        var thumbnailCenter:CGPoint = CGPoint();
        let columnNumber = CGFloat(max(0,column-1))
        let xShift = columnNumber * (thumbnailSize.width + thumbnailMargin)
        thumbnailCenter.x = thumbnailMargin + xShift + thumbnailSize.width / 2.0
        let rowNumber = CGFloat(max(0, row-1))
        thumbnailCenter.y = headerHeight + thumbnailMargin + (rowNumber * (thumbnailSize.height + thumbnailMargin)) + thumbnailSize.height / 2.0
        
        self.tapScreenAtPoint(thumbnailCenter)
    }
    
    func tapViewAndWait(tapViewAccessibilityLabel:String, waitViewAccessibilityLabel:String) -> UIView?{
        tapViewWithAccessibilityLabel(tapViewAccessibilityLabel)
        return waitForViewWithAccessibilityLabel(waitViewAccessibilityLabel)
    }
    
    func tapViewWithLabelMatching(Pattern:String) {
        if let regex = NSRegularExpression(pattern: Pattern, options: nil, error: nil) {
            let element = UIApplication.sharedApplication().accessibilityElementMatchingBlock(){ (e: UIAccessibilityElement!) -> Bool in
                if let al = e.accessibilityLabel {
                    if let check = regex.firstMatchInString(al, options: nil, range: NSMakeRange(0, count(al))) {
                        return true
                    }
                }
                return false
            }
            
            if let element = element {
                if let view = UIAccessibilityElement.viewContainingAccessibilityElement(element) {
                    tapAccessibilityElement(element, inView: view)
                }
            }

        }
        
    }
    
    func acknowledgeSystemAlertIfPossible() {
        #if arch(i386) || arch(x86_64)
        acknowledgeSystemAlert()
        #endif
    }
}