//
//  QRCoder.swift
//
//
//  Copyright © 2021 IBM. All rights reserved.
//

import Compression
import Foundation
import PromiseKit
import SwiftCBOR

public enum QRCodeError: Error {
    case qrCodeExists
}

public class QRCoder: QRCoderProtocol {
    private let base45Encoder = Base45Encoder()
    private let cose1SignParser = CoseSign1Parser()
    private let cert = HCert()

    public init() {}

    public func parse(_ payload: String) -> Promise<CBORWebToken> {
        return Promise { seal in
            let payload = payload.stripPrefix()
            let base45Decoded = try base45Encoder.decode(payload)
            guard let decompressedPayload = Compression.decompress(Data(base45Decoded)) else {
                throw ApplicationError.general("Could not decompress QR Code data")
            }
            let cosePayload = try cose1SignParser.parse(decompressedPayload)
            let cborDecodedPayload = try CBOR.decode(cosePayload?.payload ?? [])
            let certificateJson = cose1SignParser.map(cborObject: cborDecodedPayload)
            let jsonData = try JSONSerialization.data(withJSONObject: certificateJson as Any)
            let certificate = try JSONDecoder().decode(CBORWebToken.self, from: jsonData)
            seal.fulfill(certificate)
        }
    }
}
