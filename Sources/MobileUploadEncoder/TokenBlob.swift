//
//  File.swift
//  
//
//  Created by Michael Rutherford on 2/13/21.
//

import Foundation
import MobileDownload
import MobileDownloadDecoder
import MoneyAndExchangeRates

class TokenBlob {
    let simpleNumberFormatter: NumberFormatter
    let dateFormatter: DateFormatter
    
    var blobs: [String] = []
    
    var result: String {
        blobs.joined(separator: "\t")
    }
    
    init() {
        simpleNumberFormatter = NumberFormatter()
        simpleNumberFormatter.groupingSeparator = ""
        simpleNumberFormatter.decimalSeparator = "."
        
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        dateFormatter.locale = .current
    }
    
    func append(_ tokenType: MobileOrderDecoder.tokenType, _ parameters: String ...) {
        let token = tokenType.rawValue
        let blob: String
        
        if token.hasPrefix(",") {
            blob = token + "," + parameters.joined(separator: ",")
        } else {
            if token.count > 1 || parameters.count > 1 {
                fatalError("BUG: expected a single-character token followed by a single parameter")
            }
            blob = token + parameters[0]
        }
        
        blobs.append(blob)
    }
    
    func getString(_ value: Bool) -> String {
        value ? "1" : "0" // 1==true
    }
    
    func getString(_ value: Int?) -> String {
        guard let value = value else {
            return ""
        }
        return simpleNumberFormatter.string(from: value as NSNumber)!
    }
    
    func getString(_ value: Decimal?) -> String {
        guard let value = value else {
            return ""
        }
        return simpleNumberFormatter.string(from: value as NSNumber)!
    }
    
    func getString(_ value: MoneyWithoutCurrency?, numberOfDecimals: Int) -> String {
        guard let value = value else {
            return ""
        }
        let scaledAmount = value.scaledTo(numberOfDecimals: numberOfDecimals).scaledAmount
        return simpleNumberFormatter.string(from: scaledAmount as NSNumber)!
    }
    
    func getString(_ value: Date?, _ format: dateFormat) -> String {
        guard let value = value else {
            return ""
        }
        
        switch format {
        case .yyyyMMdd:
            dateFormatter.dateFormat = "yyyyMMdd"
        case .yyyyMMdd_HHmmss:
            dateFormatter.dateFormat = "yyyyMMdd:HHmmss"
        case .yyyy_MM_dd:
            dateFormatter.dateFormat = "yyyy-MM-dd"
        }
        
        let result = dateFormatter.string(from: value)
        return result
    }
    
    
    func addStringIfNotEmpty(_ token: MobileOrderDecoder.tokenType, _ string: String?) {
        if let string = string, !string.isEmpty {
            let safeString = MobileDownloadDecoderService.getsafeMobileString(string)
            append(token, safeString)
        }
    }
    
    func addRecNidIfPositive(_ token: MobileOrderDecoder.tokenType, _ recNid: Int?) {
        if let recNid = recNid, recNid > 0 {
            append(token, getString(recNid))
        }
    }
    
    func addDecimal2(_ token: MobileOrderDecoder.tokenType, _ value: MoneyWithoutCurrency?) {
        append(token, getString(value, numberOfDecimals: 2))
    }
    
    func addDecimal4(_ token: MobileOrderDecoder.tokenType, _ value: MoneyWithoutCurrency?) {
        append(token, getString(value, numberOfDecimals: 4))
    }
    
    func addDecimal2IfNonZero(_ token: MobileOrderDecoder.tokenType, _ value: MoneyWithoutCurrency?) {
        if let value = value, !value.isZero {
            append(token, getString(value, numberOfDecimals: 2))
        }
    }
    
    func addDecimal4IfNonZero(_ token: MobileOrderDecoder.tokenType, _ value: MoneyWithoutCurrency?) {
        if let value = value, !value.isZero {
            append(token, getString(value, numberOfDecimals: 4))
        }
    }
    
    func addBoolIfTrue(_ token: MobileOrderDecoder.tokenType, _ value: Bool) {
        if value {
            append(token, getString(value))
        }
    }
    
    func addBoolIfNotNull(_ token: MobileOrderDecoder.tokenType, _ value: Bool) {
        if value {
            append(token, getString(value))
        }
    }
    
    func addBool(_ token: MobileOrderDecoder.tokenType, _ value: Bool) {
        append(token, getString(value))
    }
    
    func addInt(_ token: MobileOrderDecoder.tokenType, _ value: Int?) {
        append(token, getString(value))
    }

    func addIntIfNotNull(_ token: MobileOrderDecoder.tokenType, _ value: Int?) {
        if let number = value {
            append(token, getString(number))
        }
    }
    
    func addDateIfNotNull(_ token: MobileOrderDecoder.tokenType, _ value: Date?, _ format: dateFormat) {
        if let date = value {
            append(token, getString(date, format))
        }
    }
    
    func addMoneyAsDecimal(_ token: MobileOrderDecoder.tokenType, _ value: MoneyWithoutCurrency) {
        append(token, getString(value.decimalValue))
    }
    
    func addMoneyAsDecimalIfNotNull(_ token: MobileOrderDecoder.tokenType, _ value: MoneyWithoutCurrency?) {
        if let amount = value {
            append(token, getString(amount.decimalValue))
        }
    }
    
    func addStringIfNotNull(_ token: MobileOrderDecoder.tokenType, _ value: String?) {
        if let value = value {
            append(token, value)
        }
    }
    
    func addDateAndEmpNidIfDateIsNotNull(_ token: MobileOrderDecoder.tokenType, _ date: Date?, _ empNid: Int?, _ format: dateFormat) {
        if let date = date {
            append(token, getString(date, format), getString(empNid))
        }
    }
    
}

enum dateFormat {
    case yyyy_MM_dd
    case yyyyMMdd
    case yyyyMMdd_HHmmss
}
