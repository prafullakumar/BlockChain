//
//  BlockDataModel.swift
//  BlockChain
//
//  Created by prafull kumar on 29/2/20.
//  Copyright © 2020 prafull kumar. All rights reserved.
//

import Foundation

struct BlockDataModel: Codable {
    let timestamp, producer: String
    let confirmed: Int?
    let previous, transactionMroot, actionMroot: String?
    let scheduleVersion: Int?
    let newProducers: String?
    let producerSignature: String?
    let transactions: [BlockDataModelTransaction]?
    let id: String
    let blockNum, refBlockPrefix: Int?

    enum CodingKeys: String, CodingKey {
        case timestamp, producer, confirmed, previous
        case transactionMroot = "transaction_mroot"
        case actionMroot = "action_mroot"
        case scheduleVersion = "schedule_version"
        case newProducers = "new_producers"
        case producerSignature = "producer_signature"
        case transactions, id
        case blockNum = "block_num"
        case refBlockPrefix = "ref_block_prefix"
    }
    
    struct BlockDataModelTransaction: Codable {
        let status: String?
        let cpuUsageUs, netUsageWords: Int?
        let trx: JSONAny?
        
        enum CodingKeys: String, CodingKey {
            case status
            case cpuUsageUs = "cpu_usage_us"
            case netUsageWords = "net_usage_words"
            case trx
        }
    }
    
}





// MARK: Convenience initializers

extension BlockDataModel {
    init?(data: Data) {
        do {
            self = try JSONDecoder().decode(BlockDataModel.self, from: data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
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

extension BlockDataModel.BlockDataModelTransaction {
    init?(data: Data) {
        do {
            self = try JSONDecoder().decode(BlockDataModel.BlockDataModelTransaction.self, from: data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
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
