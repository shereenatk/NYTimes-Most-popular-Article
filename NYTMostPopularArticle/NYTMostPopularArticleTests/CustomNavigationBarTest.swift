//
//  CustomNavigationBarTest.swift
//  NYTimesTests
//
//  Created by ios on 23/03/2024.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import NYTMostPopularArticle

class CustomNavigationBarTest: XCTestCase {
    
    func testCustomNavigationBar() throws {
            var leadingButtonTapped = false
            var trailingButton1Tapped = false
            var trailingButton2Tapped = false
            
            let customNavigationBar = CustomNavigationBar(
                title: "Test Title",
                leadingButtonImage: "arrow.left",
                leadingButtonAction: {
                    leadingButtonTapped = true
                },
                trailingButtonImage1: "gear",
                trailingButtonAction1: {
                    trailingButton1Tapped = true
                },
                trailingButtonImage2: "bell",
                trailingButtonAction2: {
                    trailingButton2Tapped = true
                }
            )
            
            let titleText = try customNavigationBar.inspect().find(text: "Test Title")
            XCTAssertNotNil(titleText)
            
           
        let leadingButton = try customNavigationBar.inspect().vStack().hStack(0).button(0)
            XCTAssertNotNil(leadingButton)
            
            try leadingButton.tap()
            XCTAssertTrue(leadingButtonTapped)
            
            let trailingButton1 = try customNavigationBar.inspect().vStack().hStack(0).button(4)
            XCTAssertNotNil(trailingButton1)
            
            let trailingButton2 = try customNavigationBar.inspect().vStack().hStack(0).button(5)
            XCTAssertNotNil(trailingButton2)
            
            try trailingButton1.tap()
            XCTAssertTrue(trailingButton1Tapped)
            
            try trailingButton2.tap()
            XCTAssertTrue(trailingButton2Tapped)
        }
}
