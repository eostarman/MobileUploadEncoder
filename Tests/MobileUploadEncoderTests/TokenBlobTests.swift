//
//  TokenBlobTests.swift
//  MobileUploadEncoderTests
//
//  Created by Michael Rutherford on 2/13/21.
//

import Foundation
import XCTest
import MobileDownloadDecoder
import MoneyAndExchangeRates
@testable import MobileUploadEncoder

class TokenBlobTests: XCTestCase {

    func testNilDate() throws {
        let tokenBlob = TokenBlob()
        
        tokenBlob.addDateIfNotNull(.DeliveryDate, nil, .yyyyMMdd)
        
        XCTAssertEqual(tokenBlob.result, "")
    }
    
    func testSimpleDate() throws {
        let tokenBlob = TokenBlob()
        
        tokenBlob.addDateIfNotNull(.DeliveryDate, christmasDay, .yyyyMMdd)
        
        XCTAssertEqual(tokenBlob.result, "c" + "20201225")
    }
    
    func testSimpleDateWithDashes() throws {
        let tokenBlob = TokenBlob()
        
        tokenBlob.addDateIfNotNull(.DeliveryDate, christmasDay, .yyyy_MM_dd)
        
        XCTAssertEqual(tokenBlob.result, "c" + "2020-12-25")
    }
    
    func testSimpleDateWithZeroTime() throws {
        let tokenBlob = TokenBlob()
        
        tokenBlob.addDateIfNotNull(.DeliveryDate, christmasDay, .yyyyMMdd_HHmmss)
        
        XCTAssertEqual(tokenBlob.result, "c" + "20201225:000000")
    }
    
    func testSimpleDateWithMorningTime() throws {
        let tokenBlob = TokenBlob()
        
        let time = christmasDay.addingTimeInterval(8 * 60 * 60 + 15 * 60) // 8:15:00 am
        
        tokenBlob.addDateIfNotNull(.DeliveryDate, time, .yyyyMMdd_HHmmss)
        
        XCTAssertEqual(tokenBlob.result, "c" + "20201225:081500")
    }
    
    func testSimpleDateWithAfternoonTime() throws {
        let tokenBlob = TokenBlob()
        
        let time = christmasDay.addingTimeInterval(21 * 60 * 60 + 13 * 60 + 17) // 9:13:17 pm
        
        tokenBlob.addDateIfNotNull(.DeliveryDate, time, .yyyyMMdd_HHmmss)
        
        XCTAssertEqual(tokenBlob.result, "c" + "20201225:211317")
    }
    
    func testSimpleInteger() throws {
        let tokenBlob = TokenBlob()
                
        tokenBlob.addIntIfNotNull(.OrderNumber, 123_456_789)
        
        XCTAssertEqual(tokenBlob.result, "a" + "123456789")
    }
    
    
    func testDecimal4() throws {
        let tokenBlob = TokenBlob()
        
        let amount = MoneyWithoutCurrency(amount: 1.12, numberOfDecimals: 2)
                
        tokenBlob.addDecimal4IfNonZero(.DiscountAmt, amount)
        
        XCTAssertEqual(tokenBlob.result, "i" + "11200")
    }
    
    func testDecimal2() throws {
        let tokenBlob = TokenBlob()
        
        let amount = MoneyWithoutCurrency(amount: 123.00, numberOfDecimals: 2)
                
        tokenBlob.addDecimal2IfNonZero(.EarlyPayDiscountAmt, amount)
        
        XCTAssertEqual(tokenBlob.result, "X" + "12300")
    }
    
    func testSimpleNilInteger() throws {
        let tokenBlob = TokenBlob()
                
        tokenBlob.addIntIfNotNull(.ItemWriteoffNid, nil)
        
        XCTAssertEqual(tokenBlob.result, "")
    }
    
    func testString() throws {
        let string = """
            this is a test
            of the string\tmike
            \u{C}
            """
        
        let safeString = MobileDownloadDecoderService.getsafeMobileString(string)
        
        let decodedString = MobileDownloadDecoderService.decodeSafeMobileString(safeString: safeString)
        
        XCTAssertEqual(string, decodedString)
    }
    
    func testSecondString() throws {
        let string = "\t\u{C}\r\n"
        
        let safeString = MobileDownloadDecoderService.getsafeMobileString(string)
        
        let decodedString = MobileDownloadDecoderService.decodeSafeMobileString(safeString: safeString)
        
        XCTAssertEqual(string, decodedString)
    }
    
    func testStringWithBackspace() throws {
        let string = "\u{8}"
        
        let safeString = MobileDownloadDecoderService.getsafeMobileString(string)
        
        // the \b is replace with " ", then the entire string is prefixed with the "magic" token of \b
        XCTAssertEqual(safeString, "\u{8} ")
    }
}


let christmasEve: Date = "2020-12-24"
let christmasDay: Date = "2020-12-25"
let dayAfterChristmas: Date = "2020-12-26"

// https://www.avanderlee.com/swift/expressible-literals/
extension Date: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = .current
        self = formatter.date(from: value)!
    }
}

