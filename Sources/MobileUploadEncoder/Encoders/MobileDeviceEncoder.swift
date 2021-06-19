//
//  File.swift
//  
//
//  Created by Michael Rutherford on 6/19/21.
//

import Foundation
import MobileUpload
import MobileLegacyCoder

extension MobileDevice: MobileUploadEncoder {
    enum eToken: String, LegacyEncodingToken {
        case handheldNid = "h"
        case recKey = "k"
        case applicationName = "n"
        case applicationVersion = "v"
        case sqlServer = "s"
        case sqlUser = "u"
        case integratedSecurity = "i"
        case sqlPassword = "p"
        case sqlDatabase = "d"
        case platformVersionString = "x"
        case timeStamp = "t"
        case syncSessionNid = "y"
        case syncTimestamp = "m"
    }
    
    public var encodedForMobileUpload: String {
        // "Nids    h0    k    neoTouch    v21.6.16.0    s    u    i0    p    d    xiOS 14.5    t2021-06-16 23:05:24    y9961    m2021-06-16 23:05:46"
        let tokenBlob = TokenBlob<eToken>()
        
        tokenBlob.addString(.applicationName, applicationName)
        tokenBlob.addString(.applicationVersion, applicationVersion)
        tokenBlob.addString(.platformVersionString, platformVersionString)
        tokenBlob.addDateTime(.timeStamp, timeStamp)
        tokenBlob.addInt(.syncSessionNid, syncSessionNid)
        tokenBlob.addDateTime(.syncTimestamp, syncTimestamp)
        
        return tokenBlob.result
    }
}

