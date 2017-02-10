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
        
        tl = TLLogger(Debugging: true, token: "your bot's token goes here", chat_id: "your chat id goes here")
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testExample() {
        
        tl.log("Heey this is a message", condition: .message)
        tl.log("this is a low memory warning", condition: .warning)
        tl.log("this is a custom log", condition: .custom("😅"))
        tl.log("this is a simple log")
        tl.log("this is just a test", to: "a different chat id goes here")
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
