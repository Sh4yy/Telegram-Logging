//
//  Telegram_LoggingTests.swift
//  Telegram-LoggingTests
//
//  Created by Shayan on 11/27/16.
//  Copyright © 2016 Shayan. All rights reserved.
//

import XCTest
@testable import TLLogger

class Telegram_LoggingTests: XCTestCase {
    fileprivate struct WaitData {
        static var waitExpectation: XCTestExpectation?
    }
    
    var tl : TLLogger!
    
    override func setUp() {
        super.setUp()
        
        tl = TLLogger(Debugging : true)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        tl.setup(BOT_KEY: "190675481:AAHAHAMUS8UjwUPow-rx_sGfDbLGz-Xu-rY",CHAT_ID: "124858558")
        tl.log("heey")
        tl.reportNewDownload(true)
        waitForDuration(15)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    public func waitForDuration(_ duration: TimeInterval) {
        WaitData.waitExpectation = expectation(description: "wait")
        Timer.scheduledTimer(timeInterval: duration, target: self,
                             selector: #selector(waitForDurationDone), userInfo: nil, repeats: false)
        waitForExpectations(timeout: duration + 3, handler: nil)
    }
    
    func waitForDurationDone() {
        WaitData.waitExpectation?.fulfill()
    }
    
    
    
}
