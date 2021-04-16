//  Created by Michael Rutherford on 2/14/21.

import Foundation
import MoneyAndExchangeRates
import MobileDownload
import MobileLegacyOrder

class LegacyOrderLineEncoder {
    
    static func encodeForMobileUpload(tokenBlob: TokenBlob, lines: [LegacyOrderLine]) {

        // for most of the fields we only emit the token if it differs from the prior lines value
        var promo1Nid: Int? = nil
        var unitDisc: MoneyWithoutCurrency? = nil
        var unitSplitCaseCharge: MoneyWithoutCurrency? = nil
        var unitPrice: MoneyWithoutCurrency? = nil
        var qtyOrdered: Int = 0
        var qtyShipped: Int = 0
        var qtyDeliveryDriverAdjustment: Int? = nil
        var crvContainerTypeNid: Int? = nil
        var unitDeposit: MoneyWithoutCurrency? = nil
        var unitFreight: MoneyWithoutCurrency? = nil
        var unitDeliveryCharge: MoneyWithoutCurrency? = nil
        var itemWriteoffNid: Int? = nil
        var carrierDeposit: MoneyWithoutCurrency? = nil
        var bagCredit: MoneyWithoutCurrency? = nil
        var statePickupCredit: MoneyWithoutCurrency? = nil
        var unitCRV: MoneyWithoutCurrency? = nil
        var qtyPalletOptimizationAdjustment: Int? = nil
        var wasDownloaded: Bool = false
        
        for x in lines {
            if x.qtyOrdered != qtyOrdered {
                qtyOrdered = x.qtyOrdered
                tokenBlob.addInt(.QtyOrdered, qtyOrdered)
            }
            
            if x.qtyShipped != qtyShipped {
                qtyShipped = x.qtyShipped
                tokenBlob.addInt(.QtyShipped, qtyShipped)
            }
            
            if x.qtyDeliveryDriverAdjustment != qtyDeliveryDriverAdjustment {
                qtyDeliveryDriverAdjustment = x.qtyDeliveryDriverAdjustment
                tokenBlob.addInt(.QtyDeliveryDriverAdjustment, qtyDeliveryDriverAdjustment)
            }
            
            if x.qtyLayerRoundingAdjustment != qtyPalletOptimizationAdjustment {
                qtyPalletOptimizationAdjustment = x.qtyLayerRoundingAdjustment
                tokenBlob.addInt(.QtyLayerRoundingAdjustment, qtyPalletOptimizationAdjustment)
            }
            
            if x.crvContainerTypeNid != crvContainerTypeNid {
                crvContainerTypeNid = x.crvContainerTypeNid
                tokenBlob.addInt(.CrvContainerTypeNid, crvContainerTypeNid)
            }
            
            if x.isDiscountOnly {
                // Force download of unitPrice and unitDisc
                unitPrice = x.unitPrice
                tokenBlob.addDecimal4(.UnitPrice, unitPrice)
                unitDisc = x.unitDisc
                tokenBlob.addDecimal4(.UnitDisc, unitDisc)
            } else {
                if x.unitPrice != unitPrice {
                    unitPrice = x.unitPrice
                    tokenBlob.addDecimal4(.UnitPrice, unitPrice)
                }
                
                if x.unitDisc != unitDisc {
                    unitDisc = x.unitDisc
                    tokenBlob.addDecimal4(.UnitDisc, unitDisc)
                }
            }
            
            if x.unitSplitCaseCharge != unitSplitCaseCharge {
                unitSplitCaseCharge = x.unitSplitCaseCharge
                tokenBlob.addDecimal4(.UnitSplitCaseCharge, unitSplitCaseCharge)
            }
            
            if x.unitDeposit != unitDeposit {
                unitDeposit = x.unitDeposit
                tokenBlob.addDecimal4(.UnitDeposit, unitDeposit)
            }
            
            if x.carrierDeposit != carrierDeposit {
                carrierDeposit = x.carrierDeposit
                tokenBlob.addDecimal4(.CarrierDeposit, carrierDeposit)
            }
            
            if x.bagCredit != bagCredit {
                bagCredit = x.bagCredit
                tokenBlob.addMoneyAsDecimal(.BagCredit, x.bagCredit)
            }
            
            if x.statePickupCredit != statePickupCredit {
                statePickupCredit = x.statePickupCredit
                tokenBlob.addMoneyAsDecimal(.StatePickupCredit, x.statePickupCredit)
            }
            
            if x.unitCRV != unitCRV {
                unitCRV = x.unitCRV
                tokenBlob.addMoneyAsDecimal(.UnitCRV, x.unitCRV)
            }
            
            if x.unitFreight != unitFreight {
                unitFreight = x.unitFreight
                tokenBlob.addDecimal2(.UnitFreight, unitFreight)
            }
            
            if x.unitDeliveryCharge != unitDeliveryCharge {
                unitDeliveryCharge = x.unitDeliveryCharge
                tokenBlob.addDecimal2(.UnitDeliveryCharge, x.unitDeliveryCharge)
            }
            
            if x.itemWriteoffNid != itemWriteoffNid {
                itemWriteoffNid = x.itemWriteoffNid
                tokenBlob.addInt(.ItemWriteoffNid, itemWriteoffNid)
            }
            
            if x.wasDownloaded != wasDownloaded {
                wasDownloaded = x.wasDownloaded
                tokenBlob.addInt(.WasDownloaded, wasDownloaded ? 1 : 0) // add token when the value CHANGES from the prior line
            }
            
            if x.promo1Nid != promo1Nid {
                promo1Nid = x.promo1Nid
                tokenBlob.addInt(.Promo1Nid, promo1Nid)
            }
            
            if x.promo1Nid != 0 {
                if (x.qtyDiscounted != x.qtyShipped) {
                    tokenBlob.addInt(.QtyDiscounted, x.qtyDiscounted)
                }
            }
            
            tokenBlob.addBoolIfTrue(.IsCloseDatedInMarket, x.isCloseDatedInMarket)
            tokenBlob.addBoolIfTrue(.IsManualDiscount, x.isManualDiscount)
            tokenBlob.addBoolIfTrue(.IsManualPrice, x.isManualPrice)
            tokenBlob.addBoolIfTrue(.IsManualDeposit, x.isManualDeposit)
            tokenBlob.addBoolIfTrue(.BasePricesAndPromosOnQtyOrdered, x.basePricesAndPromosOnQtyOrdered)
            tokenBlob.addBoolIfTrue(.PreservePricing, x.preservePricing)
            tokenBlob.addBoolIfTrue(.WasAutoCut, x.wasAutoCut)
            
            if let qtyBackordered = x.qtyBackordered, qtyBackordered != 0 {
                tokenBlob.addInt(.QtyBackordered, qtyBackordered)
            }
            
            //if let originalQtyShipped = x.originalQtyShipped, originalQtyShipped != 0 {
            //    tokenBlob.addIntCommaCommand(.OriginalQtyShipped, originalQtyShipped)
            //}
            //
            //if let originalItemWriteoffNid = x.originalItemWriteoffNid {
            //    tokenBlob.addIntCommaCommand(.OriginalItemWriteoffNid, originalItemWriteoffNid)
            //}
            
            if let uniqueifier = x.uniqueifier, uniqueifier != 0 {
                tokenBlob.addInt(.Uniqueifier, uniqueifier)
            }
            
            tokenBlob.addStringIfNotNull(.PickAndShipDateCodes, x.pickAndShipDateCodes)
            
            //tokenBlob.addCommaCommandIfNotNull(.DateCode, x.dateCode, .yyyyMMdd)
            
            tokenBlob.addStringIfNotEmpty(.ItemNameOverride, x.itemNameOverride)
            
            tokenBlob.addIntIfNotNull(.MergeSequenceTag, x.mergeSequenceTag)
            
            tokenBlob.addBool(.AutoFreeGoodsLine, x.autoFreeGoodsLine)
            tokenBlob.addBool(.IsPreferredFreeGoodLine, x.isPreferredFreeGoodLine)
            
            tokenBlob.addIntIfNotNull(.CMAOnNid, x.CMAOnNid)
            tokenBlob.addIntIfNotNull(.CTMOnNid, x.CTMOnNid)
            tokenBlob.addIntIfNotNull(.CCFOnNid, x.CCFOnNid)
            
            tokenBlob.addIntIfNotNull(.CMAOffNid, x.CMAOffNid)
            tokenBlob.addIntIfNotNull(.CTMOffNid, x.CTMOffNid)
            tokenBlob.addIntIfNotNull(.CCFOffNid, x.CCFOffNid)
            
            tokenBlob.addMoneyAsDecimalIfNotNull(.CMAOnAmt, x.CMAOnAmt)
            tokenBlob.addMoneyAsDecimalIfNotNull(.CTMOnAmt, x.CTMOnAmt)
            tokenBlob.addMoneyAsDecimalIfNotNull(.CCFOnAmt, x.CCFOnAmt)
            
            tokenBlob.addMoneyAsDecimalIfNotNull(.CMAOffAmt, x.CMAOffAmt)
            tokenBlob.addMoneyAsDecimalIfNotNull(.CTMOffAmt, x.CTMOffAmt)
            tokenBlob.addMoneyAsDecimalIfNotNull(.CCFOffAmt, x.CCFOffAmt)
            
            tokenBlob.addIntIfNotNull(.CommOverrideSlsEmpNid, x.commOverrideSlsEmpNid)
            tokenBlob.addIntIfNotNull(.CommOverrideDrvEmpNid, x.commOverrideDrvEmpNid)
            
            tokenBlob.addIntIfNotNull(.QtyCloseDateRequested, x.qtyCloseDateRequested)
            tokenBlob.addIntIfNotNull(.QtyCloseDateShipped, x.qtyCloseDateShipped)
            
            tokenBlob.addIntIfNotNull(.QtyShippedWhenVoided, x.qtyShippedWhenVoided) // in c#, we check order.isVoided - but this will be set only on a non-voided order
            
            tokenBlob.addIntIfNotNull(.NoteLink, x.noteLink)
            
            tokenBlob.addInt(.ItemNid, x.itemNid) // nil if a note line? It must be the last token for this line (causes an addLine() in the decoder)
        }
    }
    
}
