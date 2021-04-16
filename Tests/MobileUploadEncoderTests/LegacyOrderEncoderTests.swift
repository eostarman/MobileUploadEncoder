import XCTest
import MoneyAndExchangeRates
import MobileDownload
import MobileDownloadDecoder
import MobileLegacyOrder

@testable import MobileUploadEncoder

fileprivate let forceNils = false
fileprivate let forceTrue = false

final class LegacyOrderEncoderTests: XCTestCase {
    func testExample() {
        
        let order = LegacyOrder()
        
        //order.companyNid = 12
        order.promoDate = dayAfterChristmas
        
        let line = LegacyOrderLine()
        line.itemNid = 12
        line.qtyOrdered = 100
        line.qtyShipped = 99
        line.unitPrice = MoneyWithoutCurrency(amount: 1.25, numberOfDecimals: 2)
        
        order.lines.append(line)
        
        XCTAssertEqual(order.lines.first!.qtyOrdered, 100)
        
        let encoded = LegacyOrderEncoder.encodeLegacyOrder(order: order)
        
        let decoded = LegacyOrderDecoder.decodeLegacyOrder(blob: encoded)
        
        XCTAssertEqual(decoded.transactionCurrencyNid, order.transactionCurrencyNid)
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
    
    func testRoundTripOfAllProperties() throws {
        let order = LegacyOrder()
        order.fillWithRandomValues()
                
        let encoded = LegacyOrderEncoder.encodeLegacyOrder(order: order)
        
        let decoded = LegacyOrderDecoder.decodeLegacyOrder(blob: encoded)
        
        XCTAssertEqual(order.id, decoded.id)
        XCTAssertEqual(decoded.transactionCurrencyNid, order.transactionCurrencyNid)
        XCTAssertEqual(order.companyNid, decoded.companyNid)
        XCTAssertEqual(order.orderNumber, decoded.orderNumber)
        XCTAssertEqual(order.whseNid, decoded.whseNid)
        XCTAssertEqual(order.trkNid, decoded.trkNid)
        XCTAssertEqual(order.toCusNid, decoded.toCusNid)
        XCTAssertEqual(order.isFromDistributor, decoded.isFromDistributor)
        XCTAssertEqual(order.isToDistributor, decoded.isToDistributor)
        XCTAssertEqual(order.deliveryChargeNid, decoded.deliveryChargeNid)
        XCTAssertEqual(order.isAutoDeliveryCharge, decoded.isAutoDeliveryCharge)
        XCTAssertEqual(order.isEarlyPay, decoded.isEarlyPay)
        XCTAssertEqual(order.earlyPayDiscountAmt, decoded.earlyPayDiscountAmt)
        XCTAssertEqual(order.termDiscountDays, decoded.termDiscountDays)
        XCTAssertEqual(order.termDiscountPct, decoded.termDiscountPct)
        XCTAssertEqual(order.heldStatus, decoded.heldStatus)
        XCTAssertEqual(order.isVoided, decoded.isVoided)
        XCTAssertEqual(order.deliveredStatus, decoded.deliveredStatus)
        XCTAssertEqual(order.orderType, decoded.orderType)
        XCTAssertEqual(order.isNewOrder, decoded.isNewOrder)
        XCTAssertEqual(order.isHotShot, decoded.isHotShot)
        XCTAssertEqual(order.numberSummarized, decoded.numberSummarized)
        XCTAssertEqual(order.summaryOrderNumber, decoded.summaryOrderNumber)
        XCTAssertEqual(order.coopTicketNumber, decoded.coopTicketNumber)
        XCTAssertEqual(order.shipAdr1, decoded.shipAdr1)
        XCTAssertEqual(order.shipAdr2, decoded.shipAdr2)
        XCTAssertEqual(order.shipCity, decoded.shipCity)
        XCTAssertEqual(order.shipState, decoded.shipState)
        XCTAssertEqual(order.shipZip, decoded.shipZip)
        XCTAssertEqual(order.doNotChargeUnitFreight, decoded.doNotChargeUnitFreight)
        XCTAssertEqual(order.doNotChargeUnitDeliveryCharge, decoded.doNotChargeUnitDeliveryCharge)
        XCTAssertEqual(order.ignoreDeliveryTruckRestrictions, decoded.ignoreDeliveryTruckRestrictions)
        XCTAssertEqual(order.signatureVectors, decoded.signatureVectors)
        XCTAssertEqual(order.driverSignatureVectors, decoded.driverSignatureVectors)
        XCTAssertEqual(order.isOffScheduleDelivery, decoded.isOffScheduleDelivery)
        XCTAssertEqual(order.isSpecialPaymentTerms, decoded.isSpecialPaymentTerms)
        XCTAssertEqual(order.promoDate, decoded.promoDate)
        XCTAssertEqual(order.authenticatedDate, decoded.authenticatedDate)
        XCTAssertEqual(order.authenticatedByNid, decoded.authenticatedByNid)
        XCTAssertEqual(order.deliveredDate, decoded.deliveredDate)
        XCTAssertEqual(order.deliveredByNid, decoded.deliveredByNid)
        XCTAssertEqual(order.deliveryDocumentDate, decoded.deliveryDocumentDate)
        XCTAssertEqual(order.deliveryDocumentByNid, decoded.deliveryDocumentByNid)
        XCTAssertEqual(order.dispatchedDate, decoded.dispatchedDate)
        XCTAssertEqual(order.dispatchedByNid, decoded.dispatchedByNid)
        XCTAssertEqual(order.ediInvoiceDate, decoded.ediInvoiceDate)
        XCTAssertEqual(order.ediInvoiceByNid, decoded.ediInvoiceByNid)
        XCTAssertEqual(order.ediPaymentDate, decoded.ediPaymentDate)
        XCTAssertEqual(order.ediPaymentByNid, decoded.ediPaymentByNid)
        XCTAssertEqual(order.ediShipNoticeDate, decoded.ediShipNoticeDate)
        XCTAssertEqual(order.ediShipNoticeByNid, decoded.ediShipNoticeByNid)
        XCTAssertEqual(order.enteredDate, decoded.enteredDate)
        XCTAssertEqual(order.enteredByNid, decoded.enteredByNid)
        XCTAssertEqual(order.followupInvoiceDate, decoded.followupInvoiceDate)
        XCTAssertEqual(order.followupInvoiceByNid, decoded.followupInvoiceByNid)
        XCTAssertEqual(order.loadedDate, decoded.loadedDate)
        XCTAssertEqual(order.loadedByNid, decoded.loadedByNid)
        XCTAssertEqual(order.orderedDate, decoded.orderedDate)
        XCTAssertEqual(order.orderedByNid, decoded.orderedByNid)
        XCTAssertEqual(order.palletizedDate, decoded.palletizedDate)
        XCTAssertEqual(order.palletizedByNid, decoded.palletizedByNid)
        XCTAssertEqual(order.pickListDate, decoded.pickListDate)
        XCTAssertEqual(order.pickListByNid, decoded.pickListByNid)
        XCTAssertEqual(order.shippedDate, decoded.shippedDate)
        XCTAssertEqual(order.shippedByNid, decoded.shippedByNid)
        XCTAssertEqual(order.stagedDate, decoded.stagedDate)
        XCTAssertEqual(order.stagedByNid, decoded.stagedByNid)
        XCTAssertEqual(order.verifiedDate, decoded.verifiedDate)
        XCTAssertEqual(order.verifiedByNid, decoded.verifiedByNid)
        XCTAssertEqual(order.voidedDate, decoded.voidedDate)
        XCTAssertEqual(order.voidedByNid, decoded.voidedByNid)
        XCTAssertEqual(order.loadNumber, decoded.loadNumber)
        XCTAssertEqual(order.isVendingReplenishment, decoded.isVendingReplenishment)
        XCTAssertEqual(order.toEquipNid, decoded.toEquipNid)
        XCTAssertEqual(order.replenishmentVendTicketNumber, decoded.replenishmentVendTicketNumber)
        XCTAssertEqual(order.isCoopDeliveryPoint, decoded.isCoopDeliveryPoint)
        XCTAssertEqual(order.coopCusNid, decoded.coopCusNid)
        XCTAssertEqual(order.doNotOptimizePalletsWithLayerRounding, decoded.doNotOptimizePalletsWithLayerRounding)
        XCTAssertEqual(order.returnsValidated, decoded.returnsValidated)
        XCTAssertEqual(order.POAAmount, decoded.POAAmount)
        XCTAssertEqual(order.POAExpected, decoded.POAExpected)
        XCTAssertEqual(order.includeChargeOrderInTotalDue, decoded.includeChargeOrderInTotalDue)
        XCTAssertEqual(order.deliverySequence, decoded.deliverySequence)
        XCTAssertEqual(order.orderDEXStatus, decoded.orderDEXStatus)
        XCTAssertEqual(order.isForPlanogramReset, decoded.isForPlanogramReset)
        XCTAssertEqual(order.manualHold, decoded.manualHold)
        XCTAssertEqual(order.pushOffDate, decoded.pushOffDate)
        XCTAssertEqual(order.drvEmpNid, decoded.drvEmpNid)
        XCTAssertEqual(order.slsEmpNid, decoded.slsEmpNid)
        XCTAssertEqual(order.orderTypeNid, decoded.orderTypeNid)
        XCTAssertEqual(order.isBillAndHold, decoded.isBillAndHold)
        XCTAssertEqual(order.paymentTermsNid, decoded.paymentTermsNid)
        XCTAssertEqual(order.isBulkOrder, decoded.isBulkOrder)
        XCTAssertEqual(order.isCharge, decoded.isCharge)
        XCTAssertEqual(order.isTaxable, decoded.isTaxable)
        XCTAssertEqual(order.usedCombinedForm, decoded.usedCombinedForm)
        XCTAssertEqual(order.isEft, decoded.isEft)
        XCTAssertEqual(order.poNumber, decoded.poNumber)
        XCTAssertEqual(order.takenFrom, decoded.takenFrom)
        XCTAssertEqual(order.invoiceNote, decoded.invoiceNote)
        XCTAssertEqual(order.packNote, decoded.packNote)
        XCTAssertEqual(order.serializedItems, decoded.serializedItems)
        XCTAssertEqual(order.receivedBy, decoded.receivedBy)
        XCTAssertEqual(order.pushOffReason, decoded.pushOffReason)
        XCTAssertEqual(order.skipReason, decoded.skipReason)
        XCTAssertEqual(order.voidReason, decoded.voidReason)
        XCTAssertEqual(order.offInvoiceDiscPct, decoded.offInvoiceDiscPct)
        XCTAssertEqual(order.discountAmt, decoded.discountAmt)
        XCTAssertEqual(order.totalFreight, decoded.totalFreight)
        XCTAssertEqual(order.isExistingOrder, decoded.isExistingOrder)
        XCTAssertEqual(order.printedReviewInvoice, decoded.printedReviewInvoice)
        XCTAssertEqual(order.voidReasonNid, decoded.voidReasonNid)
        XCTAssertEqual(order.isPresell, decoded.isPresell)
        XCTAssertEqual(order.entryTime, decoded.entryTime)
        // XCTAssertEqual(order.deliveredByHandheld, decoded.deliveredByHandheld)   - not persisted
        // XCTAssertEqual(order.isOffTruck, decoded.isOffTruck)                     - not persisted
        // XCTAssertEqual(order.isFromBlobbing, decoded.isFromBlobbing)             - not persisted
        XCTAssertEqual(order.salesTax, decoded.salesTax)
        XCTAssertEqual(order.salesTaxState, decoded.salesTaxState)
        XCTAssertEqual(order.salesTaxStateB, decoded.salesTaxStateB)
        XCTAssertEqual(order.salesTaxStateC, decoded.salesTaxStateC)
        XCTAssertEqual(order.salesTaxCounty, decoded.salesTaxCounty)
        XCTAssertEqual(order.salesTaxCity, decoded.salesTaxCity)
        XCTAssertEqual(order.salesTaxLocal, decoded.salesTaxLocal)
        XCTAssertEqual(order.salesTaxWholesale, decoded.salesTaxWholesale)
        XCTAssertEqual(order.VAT, decoded.VAT)
        XCTAssertEqual(order.levy, decoded.levy)
        
        XCTAssertEqual(order.orderNumbersForPartitioner.count, decoded.orderNumbersForPartitioner.count)
        if order.orderNumbersForPartitioner.count == decoded.orderNumbersForPartitioner.count {
            for i in 0 ..< order.orderNumbersForPartitioner.count {
                XCTAssertEqual(order.orderNumbersForPartitioner[i], decoded.orderNumbersForPartitioner[i])
            }
        }
        
        XCTAssertEqual(order.deliveryInfos.count, decoded.deliveryInfos.count)
        if order.deliveryInfos.count == decoded.deliveryInfos.count {
            for i in 0 ..< order.deliveryInfos.count {
                let x = order.deliveryInfos[i]
                let y = decoded.deliveryInfos[i]
                
                XCTAssertEqual(x.isOffScheduleDelivery, y.isOffScheduleDelivery)
                XCTAssertEqual(x.driverNid, y.driverNid)
                XCTAssertEqual(x.deliveryDate, y.deliveryDate)
            }
        }

        XCTAssertEqual(order.lines.count, decoded.lines.count)
        if order.lines.count == decoded.lines.count {
            for i in 0 ..< order.lines.count {
                let x = order.lines[i]
                let y = decoded.lines[i]
                
                XCTAssertEqual(x.itemNid, y.itemNid)
                XCTAssertEqual(x.itemWriteoffNid, y.itemWriteoffNid)
                XCTAssertEqual(x.qtyShippedWhenVoided, y.qtyShippedWhenVoided)
                XCTAssertEqual(x.qtyShipped, y.qtyShipped)
                XCTAssertEqual(x.qtyOrdered, y.qtyOrdered)
                XCTAssertEqual(x.qtyDiscounted, y.qtyDiscounted)
                XCTAssertEqual(x.promo1Nid, y.promo1Nid)
                XCTAssertEqual(x.unitDisc, y.unitDisc)
                XCTAssertEqual(x.qtyLayerRoundingAdjustment, y.qtyLayerRoundingAdjustment)
                XCTAssertEqual(x.crvContainerTypeNid, y.crvContainerTypeNid)
                XCTAssertEqual(x.qtyDeliveryDriverAdjustment, y.qtyDeliveryDriverAdjustment)
                XCTAssertEqual(x.itemNameOverride, y.itemNameOverride)
                XCTAssertEqual(x.unitPrice, y.unitPrice)
                XCTAssertEqual(x.isManualPrice, y.isManualPrice)
                XCTAssertEqual(x.unitSplitCaseCharge, y.unitSplitCaseCharge)
                XCTAssertEqual(x.unitDeposit, y.unitDeposit)
                XCTAssertEqual(x.isManualDiscount, y.isManualDiscount)
                XCTAssertEqual(x.carrierDeposit, y.carrierDeposit)
                XCTAssertEqual(x.bagCredit, y.bagCredit)
                XCTAssertEqual(x.statePickupCredit, y.statePickupCredit)
                XCTAssertEqual(x.unitFreight, y.unitFreight)
                XCTAssertEqual(x.unitDeliveryCharge, y.unitDeliveryCharge)
                XCTAssertEqual(x.qtyBackordered, y.qtyBackordered)
                XCTAssertEqual(x.isCloseDatedInMarket, y.isCloseDatedInMarket)
                XCTAssertEqual(x.isManualDeposit, y.isManualDeposit)
                XCTAssertEqual(x.basePricesAndPromosOnQtyOrdered, y.basePricesAndPromosOnQtyOrdered)
                XCTAssertEqual(x.wasAutoCut, y.wasAutoCut)
                XCTAssertEqual(x.mergeSequenceTag, y.mergeSequenceTag)
                XCTAssertEqual(x.autoFreeGoodsLine, y.autoFreeGoodsLine)
                XCTAssertEqual(x.isPreferredFreeGoodLine, y.isPreferredFreeGoodLine)
                XCTAssertEqual(x.uniqueifier, y.uniqueifier)
                XCTAssertEqual(x.wasDownloaded, y.wasDownloaded)
                XCTAssertEqual(x.pickAndShipDateCodes, y.pickAndShipDateCodes)
                XCTAssertEqual(x.dateCode, y.dateCode)
                XCTAssertEqual(x.CMAOnNid, y.CMAOnNid)
                XCTAssertEqual(x.CTMOnNid, y.CTMOnNid)
                XCTAssertEqual(x.CCFOnNid, y.CCFOnNid)
                XCTAssertEqual(x.CMAOffNid, y.CMAOffNid)
                XCTAssertEqual(x.CTMOffNid, y.CTMOffNid)
                XCTAssertEqual(x.CCFOffNid, y.CCFOffNid)
                XCTAssertEqual(x.CMAOnAmt, y.CMAOnAmt)
                XCTAssertEqual(x.CTMOnAmt, y.CTMOnAmt)
                XCTAssertEqual(x.CCFOnAmt, y.CCFOnAmt)
                XCTAssertEqual(x.CMAOffAmt, y.CMAOffAmt)
                XCTAssertEqual(x.CTMOffAmt, y.CTMOffAmt)
                XCTAssertEqual(x.CCFOffAmt, y.CCFOffAmt)
                XCTAssertEqual(x.commOverrideSlsEmpNid, y.commOverrideSlsEmpNid)
                XCTAssertEqual(x.commOverrideDrvEmpNid, y.commOverrideDrvEmpNid)
                XCTAssertEqual(x.qtyCloseDateRequested, y.qtyCloseDateRequested)
                XCTAssertEqual(x.qtyCloseDateShipped, y.qtyCloseDateShipped)
                XCTAssertEqual(x.preservePricing, y.preservePricing)
                XCTAssertEqual(x.noteLink, y.noteLink)
                
                XCTAssertEqual(x.unitCRV, y.unitCRV)
                
                // XCTAssertEqual(x.seq, y.seq) - we don't need to persist this
            }
        }
        
        let jsonEncoder = JSONEncoder()
        let jsonData = try jsonEncoder.encode(order)
        let json = String(data: jsonData, encoding: String.Encoding.utf8)
        
        let mmm = json?.count
    }
    

}

fileprivate func getRandomRecNidOrNil() -> Int? {
    if forceNils { return nil }
    
    let recNid = Int.random(in: 0 ... 999_999_999)
    return recNid == 0 ? nil : recNid
}

fileprivate func getRandomInt() -> Int {
    Int.random(in: 0 ... 999_999_999)
}

fileprivate func getRandomIntOrNil() -> Int? {
    if forceNils { return nil }
  
    let recNid = Int.random(in: -999 ... 999_999_999)
    return recNid == 0 ? nil : recNid
}

fileprivate func getRandomDate() -> Date {
    let randomDays = Int.random(in: -1 ... 20 * 365)
    let newDay = Calendar.current.date(byAdding: .day, value: randomDays, to: christmasEve) ?? christmasEve
    return newDay
}

fileprivate func getRandomDateOrNil() -> Date? {
    return nil
    if forceNils { return nil }
  
    return Int.random(in: 1 ... 5) == 1 ? nil : getRandomDate()
}

fileprivate func getRandomStringOrNil() -> String? {
    if forceNils { return nil }
    return "xx"
  
    switch Int.random(in: 1 ... 3) {
    case 1:
        return ""
    case 2:
        return "Mike was here"
    default:
        return nil
    }
}

fileprivate func getRandomBool() -> Bool {
    if forceTrue {
        return true
    } else {
        return false
    }
    return Bool.random()
}

fileprivate func getRandomMoneyWithoutCurrency(numberOfDecimals: Int = 4) -> MoneyWithoutCurrency {
    let scaledAmount = Int.random(in: 0 ... 999_999_999)
    let numberOfDecimals = Int.random(in: 0 ... numberOfDecimals)
    let value = MoneyWithoutCurrency(scaledAmount: scaledAmount, numberOfDecimals: numberOfDecimals)
    return value
}

fileprivate func getRandomMoneyWithoutCurrencyOrNil(numberOfDecimals: Int = 4) -> MoneyWithoutCurrency? {
    if forceNils { return nil }
  
    return Int.random(in: 1 ... 5) == 1 ? nil : getRandomMoneyWithoutCurrency(numberOfDecimals: numberOfDecimals)
}

fileprivate func getMockLegacyOrderLine() -> LegacyOrderLine {
    let legacyOrderLine = LegacyOrderLine()
    
    legacyOrderLine.fillWithRandomValues()
    
    return legacyOrderLine
}

fileprivate extension LegacyOrder {
    func fillWithRandomValues() {
        transactionCurrencyNid = getRandomInt()
        companyNid = getRandomInt()
        orderNumber = getRandomInt()
        whseNid = getRandomInt()
        trkNid = getRandomIntOrNil()
        toCusNid = getRandomInt()
        isFromDistributor = getRandomBool()
        isToDistributor = getRandomBool()
        deliveryChargeNid = getRandomIntOrNil()
        isAutoDeliveryCharge = getRandomBool()
        isEarlyPay = getRandomBool()
        earlyPayDiscountAmt = getRandomMoneyWithoutCurrencyOrNil(numberOfDecimals: 2)
        termDiscountDays = getRandomIntOrNil()
        termDiscountPct = getRandomIntOrNil()
        heldStatus = getRandomBool()
        isVoided = getRandomBool()
        deliveredStatus = getRandomBool()
        orderType = eOrderType.allCases.randomElement()
        isHotShot = getRandomBool()
        numberSummarized = getRandomIntOrNil()
        summaryOrderNumber = getRandomIntOrNil()
        coopTicketNumber = getRandomIntOrNil()
        shipAdr1 = getRandomStringOrNil()
        shipAdr2 = getRandomStringOrNil()
        shipCity = getRandomStringOrNil()
        shipState = getRandomStringOrNil()
        shipZip = getRandomStringOrNil()
        doNotChargeUnitFreight = getRandomBool()
        doNotChargeUnitDeliveryCharge = getRandomBool()
        ignoreDeliveryTruckRestrictions = getRandomBool()
        signatureVectors = getRandomStringOrNil()
        driverSignatureVectors = getRandomStringOrNil()
        isOffScheduleDelivery = getRandomBool()
        isSpecialPaymentTerms = getRandomBool()
        promoDate = getRandomDateOrNil()
        
        authenticatedDate = getRandomDateOrNil()
        authenticatedByNid = authenticatedDate == nil ? nil : getRandomInt()
        deliveredDate = getRandomDateOrNil()
        deliveredByNid = deliveredDate == nil ? nil : getRandomIntOrNil()
        deliveryDocumentDate = getRandomDateOrNil()
        deliveryDocumentByNid = deliveryDocumentDate == nil ? nil : getRandomIntOrNil()
        dispatchedDate = getRandomDateOrNil()
        dispatchedByNid = dispatchedDate == nil ? nil : getRandomIntOrNil()
        ediInvoiceDate = getRandomDateOrNil()
        ediInvoiceByNid = ediInvoiceDate == nil ? nil : getRandomIntOrNil()
        ediPaymentDate = getRandomDateOrNil()
        ediPaymentByNid = ediPaymentDate == nil ? nil :getRandomIntOrNil()
        ediShipNoticeDate = getRandomDateOrNil()
        ediShipNoticeByNid = ediShipNoticeDate == nil ? nil :getRandomIntOrNil()
        enteredDate = getRandomDateOrNil()
        enteredByNid = enteredDate == nil ? nil :getRandomIntOrNil()
        followupInvoiceDate = getRandomDateOrNil()
        followupInvoiceByNid = followupInvoiceDate == nil ? nil :getRandomIntOrNil()
        loadedDate = getRandomDateOrNil()
        loadedByNid = loadedDate == nil ? nil :getRandomIntOrNil()
        orderedDate = getRandomDateOrNil()
        orderedByNid = orderedDate == nil ? nil :getRandomIntOrNil()
        palletizedDate = getRandomDateOrNil()
        palletizedByNid = palletizedDate == nil ? nil :getRandomIntOrNil()
        pickListDate = getRandomDateOrNil()
        pickListByNid = pickListDate == nil ? nil :getRandomIntOrNil()
        shippedDate = getRandomDateOrNil()
        shippedByNid = shippedDate == nil ? nil :getRandomIntOrNil()
        stagedDate = getRandomDateOrNil()
        stagedByNid = stagedDate == nil ? nil :getRandomIntOrNil()
        verifiedDate = getRandomDateOrNil()
        verifiedByNid = verifiedDate == nil ? nil :getRandomIntOrNil()
        voidedDate = getRandomDateOrNil()
        voidedByNid = voidedDate == nil ? nil :getRandomIntOrNil()
        loadNumber = getRandomIntOrNil()
        isVendingReplenishment = getRandomBool()
        if isVendingReplenishment {
            toEquipNid = getRandomIntOrNil()
            replenishmentVendTicketNumber = getRandomIntOrNil()
        }
        isCoopDeliveryPoint = getRandomBool()
        coopCusNid = getRandomIntOrNil()
        doNotOptimizePalletsWithLayerRounding = getRandomBool()
        returnsValidated = getRandomBool()
        POAAmount = getRandomMoneyWithoutCurrencyOrNil()
        POAExpected = getRandomMoneyWithoutCurrencyOrNil()
        includeChargeOrderInTotalDue = getRandomBool()
        deliverySequence = getRandomIntOrNil()
        orderDEXStatus = eOrderDEXStatus.allCases.randomElement()
        isForPlanogramReset = getRandomBool()
        manualHold = getRandomBool()
        pushOffDate = getRandomDateOrNil()
        drvEmpNid = getRandomIntOrNil()
        slsEmpNid = getRandomIntOrNil()
        orderTypeNid = getRandomIntOrNil()
        isBillAndHold = getRandomBool()
        paymentTermsNid = getRandomIntOrNil()
        isBulkOrder = getRandomBool()
        isCharge = getRandomBool()
        isTaxable = getRandomBool()
        usedCombinedForm = getRandomBool()
        isEft = getRandomBool()
        poNumber = getRandomStringOrNil()
        takenFrom = getRandomStringOrNil()
        invoiceNote = getRandomStringOrNil()
        packNote = getRandomStringOrNil()
        serializedItems = getRandomStringOrNil()
        receivedBy = getRandomStringOrNil()
        pushOffReason = getRandomStringOrNil()
        skipReason = getRandomStringOrNil()
        voidReason = getRandomStringOrNil()
        offInvoiceDiscPct = getRandomIntOrNil()
        discountAmt = getRandomMoneyWithoutCurrencyOrNil()
        totalFreight = getRandomMoneyWithoutCurrencyOrNil()
        isExistingOrder = getRandomBool()
        printedReviewInvoice = getRandomBool()
        voidReasonNid = getRandomIntOrNil()
        entryTime = getRandomDateOrNil()
        deliveredByHandheld = getRandomBool()
        isOffTruck = getRandomBool()
        isFromBlobbing = getRandomBool()
        salesTax = getRandomMoneyWithoutCurrencyOrNil()
        salesTaxState = getRandomMoneyWithoutCurrencyOrNil()
        salesTaxStateB = getRandomMoneyWithoutCurrencyOrNil()
        salesTaxStateC = getRandomMoneyWithoutCurrencyOrNil()
        salesTaxCounty = getRandomMoneyWithoutCurrencyOrNil()
        salesTaxCity = getRandomMoneyWithoutCurrencyOrNil()
        salesTaxLocal = getRandomMoneyWithoutCurrencyOrNil()
        salesTaxWholesale = getRandomMoneyWithoutCurrencyOrNil()
        VAT = getRandomMoneyWithoutCurrencyOrNil()
        levy = getRandomMoneyWithoutCurrencyOrNil()
        
        for _ in 1 ... 5 {
            let orderLine = LegacyOrderLine()
            orderLine.fillWithRandomValues()
            lines.append(orderLine)
        }
        
        for _ in 1 ... 10 {
            orderNumbersForPartitioner.append(getRandomInt())
        }
        
        for _ in 1 ... 10 {
            let isOffScheduleDelivery = getRandomBool()
            let driverNid = getRandomInt()
            let deliveryDate = getRandomDate()
        
            let deliveryInfo = DeliveryInfoForPartitioning(isOffScheduleDelivery: isOffScheduleDelivery, driverNid: driverNid, deliveryDate: deliveryDate)
            deliveryInfos.append(deliveryInfo)
        }
    }
}

fileprivate extension LegacyOrder.DeliveryInfoForPartitioning {
    func fillWithRandomValues() {
    }
}

fileprivate extension LegacyOrderLine {
    
    func fillWithRandomValues() {
        
        itemNid = getRandomRecNidOrNil()
        itemWriteoffNid = getRandomRecNidOrNil()
        qtyShippedWhenVoided = getRandomIntOrNil()
        qtyShipped = getRandomInt()
        qtyOrdered = getRandomInt()
        qtyDiscounted = getRandomInt()
        promo1Nid = getRandomRecNidOrNil()
        unitDisc = getRandomMoneyWithoutCurrency()
        qtyLayerRoundingAdjustment = getRandomIntOrNil()
        crvContainerTypeNid = getRandomRecNidOrNil()
        qtyDeliveryDriverAdjustment = getRandomIntOrNil()
        itemNameOverride = getRandomStringOrNil()
        unitPrice = getRandomMoneyWithoutCurrency()
        isManualPrice = getRandomBool()
        unitSplitCaseCharge = getRandomMoneyWithoutCurrency()
        unitDeposit = getRandomMoneyWithoutCurrency()
        isManualDiscount = getRandomBool()
        carrierDeposit = getRandomMoneyWithoutCurrency()
        bagCredit = getRandomMoneyWithoutCurrency()
        statePickupCredit = getRandomMoneyWithoutCurrency()
        unitFreight = getRandomMoneyWithoutCurrency(numberOfDecimals: 2)
        unitDeliveryCharge = getRandomMoneyWithoutCurrency(numberOfDecimals: 2)
        qtyBackordered = getRandomIntOrNil()
        isCloseDatedInMarket = getRandomBool()
        isManualDeposit = getRandomBool()
        basePricesAndPromosOnQtyOrdered = getRandomBool()
        wasAutoCut = getRandomBool()
        mergeSequenceTag = getRandomIntOrNil()
        autoFreeGoodsLine = getRandomBool()
        isPreferredFreeGoodLine = getRandomBool()
        uniqueifier = getRandomIntOrNil()
        wasDownloaded = getRandomBool()
        pickAndShipDateCodes = getRandomStringOrNil()
        dateCode = getRandomDateOrNil()
        CMAOnNid = getRandomRecNidOrNil()
        CTMOnNid = getRandomRecNidOrNil()
        CCFOnNid = getRandomRecNidOrNil()
        CMAOffNid = getRandomRecNidOrNil()
        CTMOffNid = getRandomRecNidOrNil()
        CCFOffNid = getRandomRecNidOrNil()
        CMAOnAmt = getRandomMoneyWithoutCurrency()
        CTMOnAmt = getRandomMoneyWithoutCurrency()
        CCFOnAmt = getRandomMoneyWithoutCurrency()
        CMAOffAmt = getRandomMoneyWithoutCurrency()
        CTMOffAmt = getRandomMoneyWithoutCurrency()
        CCFOffAmt = getRandomMoneyWithoutCurrency()
        commOverrideSlsEmpNid = getRandomRecNidOrNil()
        commOverrideDrvEmpNid = getRandomRecNidOrNil()
        qtyCloseDateRequested = getRandomIntOrNil()
        qtyCloseDateShipped = getRandomIntOrNil()
        preservePricing = getRandomBool()
        noteLink = getRandomIntOrNil()
        unitCRV = getRandomMoneyWithoutCurrency()
        seq = getRandomInt()
    }
}
