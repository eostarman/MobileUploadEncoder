//  Created by Michael Rutherford on 2/13/21.

import Foundation
import MoneyAndExchangeRates
import MobileLegacyOrder

struct LegacyOrderEncoder {
    static func encodeLegacyOrder(order: LegacyOrder) -> String {
        let blob = order.encodeForMobileUpload()
        return blob
    }
}

fileprivate extension LegacyOrder {
    
    func encodeForMobileUpload() -> String {
        let tokenBlob = TokenBlob()
        
        tokenBlob.addRecNidIfPositive(.TransactionCurrencyNid, transactionCurrencyNid);
        tokenBlob.addRecNidIfPositive(.CompanyNid, companyNid);
        tokenBlob.addIntIfNotNull(.OrderNumber, orderNumber);
        tokenBlob.addRecNidIfPositive(.WhseNid, whseNid);
        tokenBlob.addRecNidIfPositive(.TrkNid, trkNid);
        tokenBlob.addRecNidIfPositive(.CusNid, toCusNid);
        tokenBlob.addDateIfNotNull(.PushOffDate, pushOffDate, .yyyy_MM_dd);
        
        tokenBlob.addDateIfNotNull(.PromoDate, promoDate, .yyyyMMdd)
        tokenBlob.addDateAndEmpNidIfDateIsNotNull(.Authenticated, authenticatedDate, authenticatedByNid, .yyyyMMdd_HHmmss)
        tokenBlob.addDateAndEmpNidIfDateIsNotNull(.Delivered, deliveredDate, deliveredByNid, .yyyyMMdd_HHmmss)
        tokenBlob.addDateAndEmpNidIfDateIsNotNull(.DeliveryDocument, deliveryDocumentDate, deliveryDocumentByNid, .yyyyMMdd_HHmmss)
        tokenBlob.addDateAndEmpNidIfDateIsNotNull(.Dispatched, dispatchedDate, dispatchedByNid, .yyyyMMdd_HHmmss)
        tokenBlob.addDateAndEmpNidIfDateIsNotNull(.EdiInvoice, ediInvoiceDate, ediInvoiceByNid, .yyyyMMdd_HHmmss)
        tokenBlob.addDateAndEmpNidIfDateIsNotNull(.EdiPayment, ediPaymentDate, ediPaymentByNid, .yyyyMMdd_HHmmss)
        tokenBlob.addDateAndEmpNidIfDateIsNotNull(.EdiShipNotice, ediShipNoticeDate, ediShipNoticeByNid, .yyyyMMdd_HHmmss)
        tokenBlob.addDateAndEmpNidIfDateIsNotNull(.Entered, enteredDate, enteredByNid, .yyyyMMdd_HHmmss)
        tokenBlob.addDateAndEmpNidIfDateIsNotNull(.FollowupInvoice, followupInvoiceDate, followupInvoiceByNid, .yyyyMMdd_HHmmss)
        tokenBlob.addDateAndEmpNidIfDateIsNotNull(.Loaded, loadedDate, loadedByNid, .yyyyMMdd_HHmmss)
        tokenBlob.addDateIfNotNull(.Ordered, orderedDate, .yyyyMMdd_HHmmss)
        tokenBlob.addDateAndEmpNidIfDateIsNotNull(.Palletized, palletizedDate, palletizedByNid, .yyyyMMdd_HHmmss)
        tokenBlob.addDateAndEmpNidIfDateIsNotNull(.PickList, pickListDate, pickListByNid, .yyyyMMdd_HHmmss)
        tokenBlob.addDateIfNotNull(.Shipped, shippedDate, .yyyyMMdd_HHmmss)
        tokenBlob.addDateAndEmpNidIfDateIsNotNull(.Staged, stagedDate, stagedByNid, .yyyyMMdd_HHmmss)
        tokenBlob.addDateAndEmpNidIfDateIsNotNull(.Verified, verifiedDate, verifiedByNid, .yyyyMMdd_HHmmss)
        tokenBlob.addDateAndEmpNidIfDateIsNotNull(.Voided, voidedDate, voidedByNid, .yyyyMMdd_HHmmss)
        
        tokenBlob.addBoolIfNotNull(.DoNotOptimizePalletsWithLayerRounding, doNotOptimizePalletsWithLayerRounding)
        
        tokenBlob.addRecNidIfPositive(.DriverNid, drvEmpNid)
        tokenBlob.addRecNidIfPositive(.SlsEmpNid, slsEmpNid)
        tokenBlob.addRecNidIfPositive(.PaymentTermsNid, paymentTermsNid)
        tokenBlob.addBoolIfTrue(.TaxableFlag, isTaxable)
        tokenBlob.addBoolIfTrue(.UsedCombinedForm, usedCombinedForm)
        tokenBlob.addBoolIfTrue(.EFTFlag, isEft)
        tokenBlob.addBoolIfTrue(.IsChargeFlag, isCharge)
        tokenBlob.addBoolIfTrue(.IsBulkOrderFlag, isBulkOrder)
        tokenBlob.addStringIfNotEmpty(.PONum, poNumber)
        tokenBlob.addStringIfNotEmpty(.PlacedWith, takenFrom)            // PlacedWith --> TakenFrom
        tokenBlob.addStringIfNotEmpty(.DeliveryNote, invoiceNote)
        tokenBlob.addStringIfNotEmpty(.PackNote, packNote)
        tokenBlob.addStringIfNotEmpty(.SerializedItems, serializedItems)
        tokenBlob.addIntIfNotNull(.OffInvoiceDiscPct, offInvoiceDiscPct)
        
        tokenBlob.addDecimal4IfNonZero(.DiscountAmt, discountAmt)
        tokenBlob.addDecimal4IfNonZero(.TotalTax, salesTax)
        tokenBlob.addDecimal4IfNonZero(.SalesTaxCounty, salesTaxCounty)
        tokenBlob.addDecimal4IfNonZero(.SalesTaxState, salesTaxState)
        tokenBlob.addDecimal4IfNonZero(.SalesTaxLocal, salesTaxLocal)
        tokenBlob.addDecimal4IfNonZero(.SalesTaxCity, salesTaxCity)
        tokenBlob.addDecimal4IfNonZero(.SalesTaxWholesale, salesTaxWholesale)
        tokenBlob.addDecimal4IfNonZero(.VAT, VAT)
        tokenBlob.addDecimal4IfNonZero(.Levy, levy)
        tokenBlob.addDecimal4IfNonZero(.TotalFreight, totalFreight)
        
        tokenBlob.addBoolIfTrue(.IsExistingOrder, isExistingOrder)
        tokenBlob.addBoolIfTrue(.PrintedReviewInvoice, printedReviewInvoice)
        tokenBlob.addIntIfNotNull(.OrderType, orderType.rawValue)
        
        tokenBlob.addBoolIfTrue(.HeldStatus, heldStatus)
        tokenBlob.addBoolIfTrue(.VoidedStatus, isVoided)
        tokenBlob.addBoolIfTrue(.DeliveredStatus, deliveredStatus)
        tokenBlob.addBoolIfTrue(.IsHotShot, isHotShot)
        tokenBlob.addBoolIfTrue(.IsFromDistributor, isFromDistributor)
        tokenBlob.addBoolIfTrue(.IsToDistributor, isToDistributor)
        tokenBlob.addIntIfNotNull(.NumberSummarized, numberSummarized)
        tokenBlob.addIntIfNotNull(.SummaryOrderNumber, summaryOrderNumber)
        
        tokenBlob.addIntIfNotNull(.CoopTicketNumber, coopTicketNumber)
        
        tokenBlob.addStringIfNotEmpty(.ShipAdr1, shipAdr1)
        tokenBlob.addStringIfNotEmpty(.ShipAdr2, shipAdr2)
        tokenBlob.addStringIfNotEmpty(.ShipCity, shipCity)
        tokenBlob.addStringIfNotEmpty(.ShipState,shipState)
        tokenBlob.addStringIfNotEmpty(.ShipZip,  shipZip)
        
        tokenBlob.addStringIfNotEmpty(.ReceivedBy, receivedBy)
        tokenBlob.addStringIfNotEmpty(.PushOffReason, pushOffReason)
        tokenBlob.addStringIfNotEmpty(.VoidReason, voidReason)
        tokenBlob.addRecNidIfPositive(.VoidReasonNid, voidReasonNid)
        
        // early pay discount stuff
        
        tokenBlob.addBoolIfTrue(.IsEarlyPay, isEarlyPay)
        tokenBlob.addDecimal2IfNonZero(.EarlyPayDiscountAmt, earlyPayDiscountAmt)
        tokenBlob.addIntIfNotNull(.TermDiscountDays, termDiscountDays)
        tokenBlob.addIntIfNotNull(.TermDiscountPct, termDiscountPct)
        
        tokenBlob.addRecNidIfPositive(.OrderTypeNid, orderTypeNid)
        tokenBlob.addBoolIfTrue(.IsBillAndHold, isBillAndHold)
        
        // added delivery charge stuff 7/5/06
        tokenBlob.addRecNidIfPositive(.DeliveryChargeNid, deliveryChargeNid)
        tokenBlob.addBoolIfTrue(.IsAutoDeliveryCharge, isAutoDeliveryCharge)
        
        tokenBlob.addBoolIfNotNull(.DoNotChargeUnitFreight, doNotChargeUnitFreight)
        tokenBlob.addBoolIfNotNull(.DoNotChargeUnitDeliveryCharge, doNotChargeUnitDeliveryCharge)
        tokenBlob.addBoolIfNotNull(.IgnoreDeliveryTruckRestrictions, ignoreDeliveryTruckRestrictions)
        tokenBlob.addBoolIfNotNull(.IsOffScheduleDelivery, isOffScheduleDelivery)
        tokenBlob.addBoolIfNotNull(.IsSpecialPaymentTerms, isSpecialPaymentTerms)
        tokenBlob.addStringIfNotNull(.SignatureVectors, signatureVectors) // SignatureVector.Serialize(signatureVectors))
        tokenBlob.addStringIfNotNull(.DriverSignatureVectors, driverSignatureVectors) //, SignatureVector.Serialize(driverSignatureVectors))
        tokenBlob.addBoolIfNotNull(.ReturnsValidated, returnsValidated)
        
        if !orderNumbersForPartitioner.isEmpty {
            let csv = orderNumbersForPartitioner.map({String($0)}).joined(separator: ",")
            tokenBlob.addStringIfNotNull(.PartOrderNumbers, csv)
        }
        
        tokenBlob.addIntIfNotNull(.LoadNumber, loadNumber)
        
        if !deliveryInfos.isEmpty {
            for deliveryInfo in deliveryInfos {
                let isOffScheduleDelivery = tokenBlob.getString(deliveryInfo.isOffScheduleDelivery) // false --> "0" rather than "" as created by c#, but meh
                let driverNid = tokenBlob.getString(deliveryInfo.driverNid)
                let date = tokenBlob.getString(deliveryInfo.deliveryDate, .yyyyMMdd)
                let csv = [isOffScheduleDelivery, driverNid, date].joined(separator: ",")
                tokenBlob.addStringIfNotNull(.PartDeliveryInfo, csv)
            }
        }
        
        if isVendingReplenishment {
            tokenBlob.addIntIfNotNull(.ToEquipNid, toEquipNid)
            tokenBlob.addStringIfNotNull(.IsVendingReplenishment, isVendingReplenishment ? "true" : "false") // we used c#'s bool.ToString() rather than the standard (for MobileDownload encoding) of "1" or "0"
            tokenBlob.addIntIfNotNull(.ReplenishmentVendTicketNumber, replenishmentVendTicketNumber)
        }

        tokenBlob.addBoolIfNotNull(.IsCoopDeliveryPoint, isCoopDeliveryPoint)
        
        tokenBlob.addIntIfNotNull(.CoopCusNid, coopCusNid)
        
        tokenBlob.addMoneyAsDecimalIfNotNull(.POAAmount, POAAmount)
        tokenBlob.addMoneyAsDecimalIfNotNull(.POAExpected, POAExpected)
        
        tokenBlob.addBoolIfNotNull(.IncludeChargeOrderInTotalDue, includeChargeOrderInTotalDue)
        
        tokenBlob.addIntIfNotNull(.DeliverySequence, deliverySequence)
        
        tokenBlob.addMoneyAsDecimalIfNotNull(.SalesTaxStateB, salesTaxStateB)
        tokenBlob.addMoneyAsDecimalIfNotNull(.SalesTaxStateC, salesTaxStateC)
        
        tokenBlob.addIntIfNotNull(.OrderDEXStatus, orderDEXStatus?.rawValue)
        
        tokenBlob.addBoolIfNotNull(.IsForPlanogramReset, isForPlanogramReset)
        
        tokenBlob.addBoolIfNotNull(.ManualHold, manualHold)
    
        LegacyOrderLineEncoder.encodeForMobileUpload(tokenBlob: tokenBlob, lines: lines)
        return tokenBlob.result
    }
}
