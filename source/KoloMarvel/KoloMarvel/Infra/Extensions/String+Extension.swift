//
//  String+Extension.swift
//  KoloMarvel
//
//  Created by Ravindran on 03/05/22.
//

import Foundation
import CryptoKit

extension String {
    var urlEncoded: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    
    func md5() -> String {
        return Insecure.MD5.hash(data: self.data(using: .utf8)!).map { String(format: "%02hhx", $0) }.joined()
    }
}
