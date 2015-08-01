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
        //go to pick image bihavior view controller
        tester.tapViewAndWait(TableCells.ImagePickerBehaviorCell.rawValue, waitViewAccessibilityLabel: NavBarTitle.ImagePickersList.rawValue)
    }
    
    override func tearDown() {
        //go to the root view controller
        tester.tapViewWithAccessibilityLabel(ButtonLabel.Back.rawValue)
        tester.tapViewWithAccessibilityLabel(ButtonLabel.Back.rawValue)
        super.tearDown()
    }
    
    func testImagePicker_SelectSourceType_Photo() {
        tester.tapViewWithAccessibilityLabel(TableCells.SelectSourceType.rawValue)
        tester.waitForViewWithAccessibilityLabel(NavBarTitle.SelectSourceType.rawValue)
        
        tester.tapViewAndWait(ButtonLabel.GetImage.rawValue, waitViewAccessibilityLabel: ButtonLabel.Photo.rawValue)
        tester.tapViewWithAccessibilityLabel(ButtonLabel.Photo.rawValue, traits: UIAccessibilityTraitButton)

        tester.acknowledgeSystemAlertIfPossible()

        tester.tapViewAndWait(TableCells.CameraRoll.rawValue, waitViewAccessibilityLabel: ButtonLabel.Photos.rawValue)
        tester.tapViewWithLabelMatching("Photo, [Lanscape,Portrait]*")
        tester.waitForViewWithAccessibilityLabel(NavBarTitle.SelectSourceType.rawValue)
        if let imageView: UIImageView = tester.waitForViewWithAccessibilityLabel(ButtonLabel.ImageView.rawValue) as? UIImageView {
            XCTAssertNotNil(imageView.image,"nil result image")
        } else {
            XCTAssert(false, "Cant find image view with result image")
        }
    }

    func testImagePicker_SelectSourceType_Camera() {
        //fo emulator the same as testImagePicker_SelectSourceType_Photo
        if TARGET_IPHONE_SIMULATOR == 1 {
            tester.tapViewWithAccessibilityLabel(TableCells.SelectSourceType.rawValue)
            tester.waitForViewWithAccessibilityLabel(NavBarTitle.SelectSourceType.rawValue)
            
            tester.tapViewAndWait(ButtonLabel.GetImage.rawValue, waitViewAccessibilityLabel: ButtonLabel.Camera.rawValue)
            tester.tapViewWithAccessibilityLabel(ButtonLabel.Camera.rawValue, traits: UIAccessibilityTraitButton)

            tester.acknowledgeSystemAlertIfPossible()
            
            tester.tapViewAndWait(TableCells.CameraRoll.rawValue, waitViewAccessibilityLabel: ButtonLabel.Photos.rawValue)
            tester.tapViewWithLabelMatching("Photo, [Lanscape,Portrait]*")
            tester.waitForViewWithAccessibilityLabel(NavBarTitle.SelectSourceType.rawValue)
            if let imageView: UIImageView = tester.waitForViewWithAccessibilityLabel(ButtonLabel.ImageView.rawValue) as? UIImageView {
                XCTAssertNotNil(imageView.image,"nil result image")
            } else {
                XCTAssert(false, "Cant find image view with result image")
            }
        } else {
            tester.tapViewWithAccessibilityLabel(TableCells.SelectSourceType.rawValue)
            tester.waitForViewWithAccessibilityLabel(NavBarTitle.SelectSourceType.rawValue)
            
            tester.tapViewAndWait(ButtonLabel.GetImage.rawValue, waitViewAccessibilityLabel: ButtonLabel.Camera.rawValue)
            tester.tapViewWithAccessibilityLabel(ButtonLabel.Camera.rawValue, traits: UIAccessibilityTraitButton)
            
            tester.acknowledgeSystemAlertIfPossible()
            tester.tapViewAndWait(ButtonLabel.TakePicture.rawValue, waitViewAccessibilityLabel: ButtonLabel.UsePhoto.rawValue)
            tester.tapViewAndWait(ButtonLabel.UsePhoto.rawValue, waitViewAccessibilityLabel: NavBarTitle.SelectSourceType.rawValue)
            if let imageView: UIImageView = tester.waitForViewWithAccessibilityLabel(ButtonLabel.ImageView.rawValue) as? UIImageView {
                XCTAssertNotNil(imageView.image,"nil result image")
            } else {
                XCTAssert(false, "Cant find image view with result image")
            }
        }
        
    }

    func testImagePicker_SelectSourceType_SavedPhotos() {
        tester.tapViewWithAccessibilityLabel(TableCells.SelectSourceType.rawValue)
        tester.waitForViewWithAccessibilityLabel(NavBarTitle.SelectSourceType.rawValue)
        
        tester.tapViewAndWait(ButtonLabel.GetImage.rawValue, waitViewAccessibilityLabel: ButtonLabel.SavedPhotos.rawValue)
        tester.tapViewWithAccessibilityLabel(ButtonLabel.SavedPhotos.rawValue, traits: UIAccessibilityTraitButton)
        
        tester.acknowledgeSystemAlertIfPossible()

        tester.waitForViewWithAccessibilityLabel(ButtonLabel.Moments.rawValue)
        tester.tapViewWithLabelMatching("Photo, [Lanscape,Portrait]*")
        tester.waitForViewWithAccessibilityLabel(NavBarTitle.SelectSourceType.rawValue)
        if let imageView: UIImageView = tester.waitForViewWithAccessibilityLabel(ButtonLabel.ImageView.rawValue) as? UIImageView {
            XCTAssertNotNil(imageView.image,"nil result image")
        } else {
            XCTAssert(false, "Cant find image view with result image")
        }
    }


    
    
    func testImagePicker_SelectFromLibrary() {
        tester.tapViewWithAccessibilityLabel(TableCells.SelectFromLibrary.rawValue)
        tester.waitForViewWithAccessibilityLabel(NavBarTitle.SelectFromLibrary.rawValue)
        
        
        tester.tapViewWithAccessibilityLabel(ButtonLabel.GetImage.rawValue, traits: UIAccessibilityTraitButton)
        tester.acknowledgeSystemAlertIfPossible()
        
        tester.waitForViewWithAccessibilityLabel(ButtonLabel.Moments.rawValue)
        tester.tapViewWithLabelMatching("Photo, [Lanscape,Portrait]*")
        tester.waitForViewWithAccessibilityLabel(NavBarTitle.SelectFromLibrary.rawValue)
        if let imageView: UIImageView = tester.waitForViewWithAccessibilityLabel(ButtonLabel.ImageView.rawValue) as? UIImageView {
            XCTAssertNotNil(imageView.image,"nil result image")
        } else {
            XCTAssert(false, "Cant find image view with result image")
        }
    }
    
    
    func testImagePicker_ManualHandle() {
        tester.tapViewWithAccessibilityLabel(TableCells.ManualHandle.rawValue)
        tester.waitForViewWithAccessibilityLabel(NavBarTitle.ManualHandle.rawValue)
        
        
        tester.tapViewWithAccessibilityLabel(ButtonLabel.GetImage.rawValue, traits: UIAccessibilityTraitButton)
        tester.acknowledgeSystemAlertIfPossible()
        
        tester.tapViewAndWait(TableCells.CameraRoll.rawValue, waitViewAccessibilityLabel: ButtonLabel.Photos.rawValue)
        tester.tapViewWithLabelMatching("Photo, [Lanscape,Portrait]*")
        tester.waitForViewWithAccessibilityLabel(ButtonLabel.Choose.rawValue)
        tester.tapViewWithAccessibilityLabel(ButtonLabel.Choose.rawValue)
        tester.waitForViewWithAccessibilityLabel(NavBarTitle.ManualHandle.rawValue)
        if let imageView: UIImageView = tester.waitForViewWithAccessibilityLabel(ButtonLabel.ImageView.rawValue) as? UIImageView {
            XCTAssertNotNil(imageView.image,"nil result image")
        } else {
            XCTAssert(false, "Cant find image view with result image")
        }
    }

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
        case CameraRoll = "Camera Roll"

    }
    
    enum ButtonLabel: String {
        case Back = "Back"
        case GetImage = "Get Image"
        case PickImage = "Pick Image"
        case ImageView = "Image View"
        case Photo = "Photo"
        case Camera = "Camera"
        case SavedPhotos = "Saved photos"
        case TakePicture = "Take picture"
        case UsePhoto = "Use photo"
        
        case Photos = "Photos"
        case Moments = "Moments"
        case Choose = "Choose"

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