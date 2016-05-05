//
//  SMABannerViewTests.swift
//
//  Created by Bill Burgess on 5/4/16.
//  Copyright © 2016 Simply Made Apps. All rights reserved.
//

import XCTest
@testable import SMABannerView

class SMABannerViewTests: SMATestCase {
    
    var banner = SMABannerView()

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitWithCoder() {
        let banner = SMABannerView.init(coder: NSCoder.empty())
        
        XCTAssertNotNil(banner)
        XCTAssertFalse((banner?.isShowing)!)
        XCTAssertFalse((banner?.isAnimating)!)
        XCTAssertEqual(banner?.alignment, SMABannerAlignment.Center)
    }
    
    func testDefaultInit() {
        let banner = SMABannerView.init()
        
        XCTAssertNotNil(banner)
        XCTAssertFalse(banner.isShowing)
        XCTAssertFalse(banner.isAnimating)
        XCTAssertEqual(banner.alignment, SMABannerAlignment.Center)
    }

    func testConvenienceInit() {
        let title = "Title String"
        let message = "Message String"
        let view = UIView()
        
        let banner = SMABannerView(title: title, message: message, view: view)
        
        XCTAssertNotNil(banner)
        XCTAssertEqual(banner.titleString, title)
        XCTAssertEqual(banner.messageString, message)
        XCTAssertEqual(banner.containerView, view)
    }
    
    func testBannerAlignmentEnumCenter() {
        let view = UIView()
        let banner = SMABannerView(title: "Title", message: "Message", view: view)
        banner.animationDuration = 0.0
        banner.alignment = .Center
        banner.show()
        
        XCTAssertEqual(banner.titleLabel?.textAlignment, .Center)
        XCTAssertEqual(banner.messageLabel?.textAlignment, .Center)
    }
    
    func testBannerAlignmentEnumLeft() {
        let view = UIView()
        let banner = SMABannerView(title: "Title", message: "Message", view: view)
        banner.animationDuration = 0.0
        banner.alignment = .Left
        banner.show()
        
        XCTAssertEqual(banner.titleLabel?.textAlignment, .Left)
        XCTAssertEqual(banner.messageLabel?.textAlignment, .Left)
    }
    
    func testBannerAlignmentEnumRight() {
        let view = UIView()
        let banner = SMABannerView(title: "Title", message: "Message", view: view)
        banner.animationDuration = 0.0
        banner.alignment = .Right
        banner.show()
        
        XCTAssertEqual(banner.titleLabel?.textAlignment, .Right)
        XCTAssertEqual(banner.messageLabel?.textAlignment, .Right)
    }
    
    func testShowWorks() {
        let view = UIView()
        let banner = SMABannerView(title: "Title", message: "Message", view: view)
        banner.animationDuration = 0.0
        banner.show()
        
        for view in view.subviews {
            XCTAssertEqual(view, banner)
        }
    }
    
    func testShowOnlyWorksOnce() {
        let view = UIView()
        let banner = SMABannerView(title: "Title", message: "Message", view: view)
        banner.animationDuration = 0.0
        banner.show()
        banner.show()
        
        XCTAssertEqual(view.subviews.count, 1)
    }
    
    func testShowWithDurationWorks() {
        let view = UIView()
        let banner = SMABannerView(title: "Title", message: "Message", view: view)
        banner.animationDuration = 0.0
        banner.show(0.01)
        
        XCTAssertEqual(view.subviews.count, 1)
    }
    
    func testShowWithDurationOnCompletionWorks() {
        let expectation = expectationWithDescription("Wait for show() to complete")
        
        let view = UIView()
        let banner = SMABannerView(title: "Title", message: "Message", view: view)
        banner.animationDuration = 0.0
        banner.show(0.01) { 
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(1) { (error) in
            XCTAssertFalse(banner.isShowing)
            XCTAssertFalse(banner.isAnimating)
        }
    }
    
    func testHideWorks() {
        let expectation = expectationWithDescription("Wait for hide() to complete")
        
        let view = UIView()
        let banner = SMABannerView(title: "Title", message: "Message", view: view)
        banner.animationDuration = 0.0
        banner.show()
        
        banner.hide { () in
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(1) { (error) in
            XCTAssertFalse(banner.isShowing)
            XCTAssertFalse(banner.isAnimating)
            XCTAssertTrue(view.subviews.count == 0)
        }
    }
    
    func testDisplayPropertiesSetAfterAnimation() {
        //XCTFail()
    }
    
}
