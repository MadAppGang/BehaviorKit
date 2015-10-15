//
//  BheaviorKitDemoUITests.swift
//  BheaviorKitDemoUITests
//
//  Created by Ievgen Rudenko on 15/10/15.
//  Copyright © 2015 MadAppGang. All rights reserved.
//

import XCTest

class BheaviorKitDemoUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Image picker behavior"].tap()
        tablesQuery.staticTexts["Select source type"].tap()
        app.buttons["Get Image"].tap()
        app.sheets.collectionViews.buttons["Photo"].tap()
        //app.alerts["\U201cBheaviorKitDemo\U201d Would Like to Access Your Photos"].collectionViews.buttons["OK"].tap()
        tablesQuery.buttons["Moments"].tap()
        app.collectionViews.cells["Photo, Landscape, August 08, 2012, 11:52 AM"].tap()
        app.images["Image View"].tap()
    }
    
    
    
    
}
