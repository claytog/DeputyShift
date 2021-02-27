//
//  DeputyShiftTests.swift
//  DeputyShiftTests
//
//  Created by Clayton on 24/2/21.
//

import XCTest
@testable import DeputyShift

class DeputyShiftTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCreateShiftPost() {
        /// Test create an instance of ShiftPost
        
        let testPostShift = ShiftPost()
        
        XCTAssertTrue(testPostShift.latitude == "0.00000" && testPostShift.longitude == "0.00000")
    }
    
    func testDateToString() {
        /// Test the formatDateToString function successfully converts the date to a string
        
        let isoDate = "2021-04-14T10:44:00+1000"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from:isoDate)!
        
        let dateString = Util.shared.formatDateToString(date: date, dateType: .long)
        
        XCTAssertTrue(dateString == isoDate)
        
    }
    
    func testStringToDate() {
        /// Test the formatStringToDate function successfully converts the string to a date
        
        let isoDate = "2021-04-14T10:44:00+1000"
        
        var dateString = ""
        
        if let date = Util.shared.formatStringToDate(dateStr: isoDate, dateType: .long) {
            dateString = Util.shared.formatDateToString(date: date, dateType: .long)
        }
        XCTAssertTrue(isoDate == dateString)
        
    }

}
