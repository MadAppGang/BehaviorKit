//
//  ImagePickerTests.swift
//  BheaviorKitDemo
//
//  Created by Ievgen Rudenko on 17/07/15.
//  Copyright (c) 2015 MadAppGang. All rights reserved.
//

import Foundation


import UIKit
import XCTest

class ImagePickerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        tester.tapViewWithAccessibilityLabel(ButtonLabel.Back.rawValue)
        super.tearDown()
    }
    
    func testLibraryImagePicker() {
        // This is an example of a functional test case.
        tester.tapViewWithAccessibilityLabel(TableCells.ImagePickerBehaviorCell.rawValue)
        tester.waitForViewWithAccessibilityLabel(NavBarTitle.ImagePickersList.rawValue)
        tester.tapViewWithAccessibilityLabel(TableCells.SelectFromLibrary.rawValue)
        tester.waitForViewWithAccessibilityLabel(NavBarTitle.SelectFromLibrary.rawValue)
        tester.tapViewWithAccessibilityLabel(ButtonLabel.GetImage.rawValue)
        
        tester.acknowledgeSystemAlert()
        tester.waitForTimeInterval(0.5)
        tester.choosePhotoInLibrary(1, column: 1)

        
        tester.waitForViewWithAccessibilityLabel(NavBarTitle.SelectFromLibrary.rawValue)
        if let imageView: UIImageView = tester.waitForViewWithAccessibilityLabel(ButtonLabel.ImageView.rawValue) as? UIImageView {
            XCTAssertNotNil(imageView.image,"nil result image")
        } else {
            XCTAssert(false, "Cant find image view with result image")
        }
    }

    func testLibraryImagePicker2() {
        // This is an example of a functional test case.
        tester.tapViewWithAccessibilityLabel(TableCells.ImagePickerBehaviorCell.rawValue)
        tester.waitForViewWithAccessibilityLabel(NavBarTitle.ImagePickersList.rawValue)
        tester.tapViewWithAccessibilityLabel(TableCells.SelectFromLibrary.rawValue)
        tester.waitForViewWithAccessibilityLabel(NavBarTitle.SelectFromLibrary.rawValue)
        tester.tapViewWithAccessibilityLabel(ButtonLabel.GetImage.rawValue)
        
        tester.acknowledgeSystemAlert()
        tester.waitForTimeInterval(0.5)
        tester.choosePhotoInLibrary(1, column: 1)
        
        
        tester.waitForViewWithAccessibilityLabel(NavBarTitle.SelectFromLibrary.rawValue)
        if let imageView: UIImageView = tester.waitForViewWithAccessibilityLabel(ButtonLabel.ImageView.rawValue) as? UIImageView {
            XCTAssertNotNil(imageView.image,"nil result image")
        } else {
            XCTAssert(false, "Cant find image view with result image")
        }
    }

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock() {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}



private extension ImagePickerTests {
    func goToMainView () {
        tester.tapViewWithAccessibilityLabel(ButtonLabel.Back.rawValue)
        tester.waitForViewWithAccessibilityLabel(NavBarTitle.MainView.rawValue, traits:UIAccessibilityTraitStaticText)
    }
    
    
    
    enum TableCells: String {
        case ImagePickerBehaviorCell = "Image Picker Behavior"
        case SelectSourceType = "Select source type"
        case SelectFromLibrary = "Select from Library"
        case ManualHandle = "Manual handle"
    }
    
    enum ButtonLabel: String {
        case Back = "Back"
        case GetImage = "Get Image"
        case ImageView = "Image View"
    }
    
    enum NavBarTitle: String {
        case MainView = "Behaviors"
        case ImagePickersList = "Image Picker Behavior"
        case SelectSourceType = "Select source type"
        case SelectFromLibrary = "Select from library"
        case ManualHandle = "Manual handle"
    }
    
    enum TextFieldLabel: String {
        case QuoteContent = "Quote Content"
        case SceneDescription = "Scene Description"
    }
    
    enum TextInput: String {
        case QuoteContent = "My Awesome Quote"
        case SceneDescription = "My Scene"
    }
    
    
    
}