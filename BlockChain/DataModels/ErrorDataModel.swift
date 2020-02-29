//
//  ErrorDataModel.swift
//  BlockChain
//
//  Created by prafull kumar on 29/2/20.
//  Copyright © 2020 prafull kumar. All rights reserved.
//


import Foundation

struct ErrorDataModel: Codable {
    let code: Int
    let message: String?
    let error: Error?
    
    struct Error: Codable {
        let code: Int?
        let name, what: String?
        let details: [Detail]?
    }
    
    struct Detail: Codable {
        let message, file: String
        let lineNumber: Int
        let method: String
        
        enum CodingKeys: String, CodingKey {
            case message, file
            case lineNumber = "line_number"
            case method
        }
    }
}



// MARK: Convenience initializers

extension ErrorDataModel {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(ErrorDataModel.self, from: data) else { return nil }
        self = me
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }

    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }

    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

extension ErrorDataModel.Error {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(ErrorDataModel.Error.self, from: data) else { return nil }
        self = me
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }

    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }

    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

extension ErrorDataModel.Detail {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(ErrorDataModel.Detail.self, from: data) else { return nil }
        self = me
    }

    init?(_ json: String, using encoding: String.Encoding = .utf8) {
        guard let data = json.data(using: encoding) else { return nil }
        self.init(data: data)
    }

    var jsonData: Data? {
        return try? JSONEncoder().encode(self)
    }

    var json: String? {
        guard let data = self.jsonData else { return nil }
        return String(data: data, encoding: .utf8)
    }
}


extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
            let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        
        return prettyPrintedString
    }
}
