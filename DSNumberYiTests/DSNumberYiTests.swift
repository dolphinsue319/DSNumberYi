//
//  DSNumberYiTests.swift
//  DSNumberYiTests
//
//  Created by Dolphin Su on 2018/1/6.
//  Copyright © 2018年 Dolphin Su. All rights reserved.
//

import XCTest
@testable import DSNumberYi

class DSNumberYiTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRemoves5InMiddle() {
        XCTAssertEqual("13", "153".remove5InMiddle())
        XCTAssertEqual("13", "15555553".remove5InMiddle())
        XCTAssertEqual("1234678", "1525354565758".remove5InMiddle())
        XCTAssertEqual("135", "135".remove5InMiddle())
        XCTAssertEqual("535", "535".remove5InMiddle())
        XCTAssertEqual("55", "555".remove5InMiddle())
        XCTAssertEqual("55", "5555".remove5InMiddle())
        XCTAssertEqual("1", "1".remove5InMiddle())
    }
    
    func testTwoDigitsStringArray() {
        XCTAssertEqual(["13"], "13".twoDigitsStringArray()!)
        XCTAssertEqual(["13", "35"], "135".twoDigitsStringArray()!)
        XCTAssertEqual(["13", "35", "57"], "1357".twoDigitsStringArray()!)
        XCTAssertNil("2".twoDigitsStringArray())
    }
    
    func testSymbolsFromString() {
        XCTAssertEqual(["天醫"], "13".symbols()!)
        XCTAssertEqual(["天醫", "延年"], "1534".symbols()!)
        XCTAssertEqual(["天醫", "延年"], "15354".symbols()!)
        XCTAssertEqual(["天醫", "延年", "伏位"], "153544".symbols()!)
        XCTAssertEqual(["天醫", "延年", "伏位"], "153545".symbols()!)
        XCTAssertEqual(["伏位", "天醫", "延年", "伏位"], "5153545".symbols()!)
    }
    
    func testSymbolsFromInt() {
        XCTAssertEqual(["天醫"], 13.symbols()!)
        XCTAssertEqual(["天醫", "延年"], 1534.symbols()!)
        XCTAssertEqual(["天醫", "延年"], 15354.symbols()!)
        XCTAssertEqual(["天醫", "延年", "伏位"], 153544.symbols()!)
        XCTAssertEqual(["天醫", "延年", "伏位"], 153545.symbols()!)
        XCTAssertEqual(["伏位", "天醫", "延年", "伏位"], 5153545.symbols()!)
    }
    
    func testAllTwoDigitNumberString() {
        for number in 10...99 {
            let string = String(number)
            XCTAssertNotNil(string.symbols())
        }
    }
}
