    import XCTest
    import MoneyAndExchangeRates
    import MobileDownload
    import MobileDownloadDecoder
    
    @testable import MobileUploadEncoder

    final class MobileOrderEncoderTests: XCTestCase {
        func testExample() {
            
            let order = MobileOrder()
            
            //order.companyNid = 12
            order.promoDate = dayAfterChristmas
            
            let line = MobileOrderLine()
            line.itemNid = 12
            line.qtyOrdered = 100
            line.qtyShipped = 99
            line.unitPrice = MoneyWithoutCurrency(amount: 1.25, numberOfDecimals: 2)
            
            order.lines.append(line)
            
            XCTAssertEqual(order.lines.first!.qtyOrdered, 100)
            
            let encoded = MobileOrderEncoder.encodeMobileOrder(order: order)
            
            let decoded = MobileOrderDecoder.decodeMobileOrder(blob: encoded)
            
            XCTAssertEqual(decoded.companyNid, order.companyNid)
            XCTAssertEqual(decoded.promoDate, order.promoDate)
            
            XCTAssertEqual(decoded.lines.count, 1)
            
            guard let line = decoded.lines.first else {
                XCTAssertEqual(decoded.lines.count, 1)
                return
            }
            
            XCTAssertEqual(line.itemNid, 12)
            XCTAssertEqual(line.qtyOrdered, 100)
            XCTAssertEqual(line.qtyShipped, 99)
            XCTAssertEqual(line.unitPrice, MoneyWithoutCurrency(amount: 1.25, numberOfDecimals: 2))
        }
    }
