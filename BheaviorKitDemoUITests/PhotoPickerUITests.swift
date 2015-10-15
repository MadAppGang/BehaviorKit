//
//  PhotoPickerUITests.swift
//  BheaviorKitDemo
//
//  Created by Ievgen Rudenko on 15/10/15.
//  Copyright © 2015 MadAppGang. All rights reserved.
//

import XCTest


class PhotoPickerUITests: XCTestCase {
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPhotoLibrary() {
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Image picker behavior"].tap()
        tablesQuery.staticTexts["Select source type"].tap()
        app.buttons["Get Image"].tap()
        app.sheets.collectionViews.buttons["Photo"].tap()
        tablesQuery.buttons["Moments"].tap()
        app.collectionViews.cells.elementBoundByIndex(1).tap()
        app.navigationBars["Select source type"].childrenMatchingType(.Button).matchingIdentifier("Back").elementBoundByIndex(0).tap()
        app.navigationBars["Image Picker Behavior"].buttons["Behaviors"].tap()
        
    }
    
    func tetstPhotosChoise() {
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Image picker behavior"].tap()
        tablesQuery.staticTexts["Select source type"].tap()
        app.buttons["Get Image"].tap()
        app.sheets.collectionViews.buttons["Saved photos"].tap()
        app.collectionViews.cells.elementBoundByIndex(1).tap()
        app.navigationBars["Select source type"].childrenMatchingType(.Button).matchingIdentifier("Back").elementBoundByIndex(0).tap()
        app.navigationBars["Image Picker Behavior"].buttons["Behaviors"].tap()
        
    }

    
    func testPredefinedSource() {
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Image picker behavior"].tap()
        tablesQuery.staticTexts["Select from Library"].tap()
        app.buttons["Get Image"].tap()
        app.collectionViews.cells.elementBoundByIndex(1).tap()
        app.navigationBars["Select from library"].childrenMatchingType(.Button).matchingIdentifier("Back").elementBoundByIndex(0).tap()
        app.navigationBars["Image Picker Behavior"].buttons["Behaviors"].tap()
        
    }
    
    func testManualHandlingOfPicking() {
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Image picker behavior"].tap()
        tablesQuery.staticTexts["Manual handle of picking (from camera)"].tap()
        app.buttons["Get Image"].tap()
        tablesQuery.buttons["Moments"].tap()
        app.collectionViews.cells.elementBoundByIndex(1).tap()
        
        let photoLandscapeAugust0820121152AmImage = app.images.elementBoundByIndex(1)
        photoLandscapeAugust0820121152AmImage.pinchWithScale(2,velocity:10)
        app.buttons["Choose"].tap()
        app.navigationBars["Manual handle"].childrenMatchingType(.Button).matchingIdentifier("Back").elementBoundByIndex(0).tap()
        app.navigationBars["Image Picker Behavior"].buttons["Behaviors"].tap()
        
    }
    
    
}
