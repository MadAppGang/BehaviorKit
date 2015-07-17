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
}