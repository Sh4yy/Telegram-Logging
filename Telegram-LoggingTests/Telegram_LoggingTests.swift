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
    
    var tl : TLLogger!
    
    override func setUp() {
        super.setUp()
        
        tl = TLLogger()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        tl.setup(BOT_KEY: "190675481:AAHAHAMUS8UjwUPow-rx_sGfDbLGz-Xu-rY",CHAT_ID: "124858558")
        tl.log("heey")
        tl.reportNewDownload()
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
