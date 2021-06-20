//
//  File.swift
//  
//
//  Created by Michael Rutherford on 6/19/21.
//

import Foundation

public struct MobileUploadInfo {
    public init(encodedMobileUpload: String, compressedMobileUpload: Data?, mobileUploadUUID: UUID) {
        self.encodedMobileUpload = encodedMobileUpload
        self.compressedMobileUpload = compressedMobileUpload
        self.mobileUploadUUID = mobileUploadUUID
    }
    
    public let encodedMobileUpload: String
    public let compressedMobileUpload: Data?
    public let mobileUploadUUID: UUID
}
