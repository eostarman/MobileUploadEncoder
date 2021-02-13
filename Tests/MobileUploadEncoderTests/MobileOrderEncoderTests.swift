    import XCTest
    import MoneyAndExchangeRates
    import MobileDownload
    import MobileDownloadDecoder
    
    @testable import MobileUploadEncoder

    final class MobileOrderEncoderTests: XCTestCase {
        func testExample() {
            
            let order = MobileOrder()
            
            order.companyNid = 12
            
            let encoded = MobileOrderEncoder.encodeMobileOrder(order: order)
            
            let decoded = MobileOrderDecoder.decodeMobileOrder(blob: encoded)
            
            XCTAssertEqual(decoded.companyNid, order.companyNid)
        }
    }
