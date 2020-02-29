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
        let trx: Trx?
        
        enum CodingKeys: String, CodingKey {
            case status
            case cpuUsageUs = "cpu_usage_us"
            case netUsageWords = "net_usage_words"
            case trx
        }
    }
    
    struct Trx: Codable {
        let id: String?
        let signatures: [String]?
        let compression, packedContextFreeData: String?
        let contextFreeData: [String]?
        let packedTrx: String?
        let transaction: TrxTransaction?
        
        enum CodingKeys: String, CodingKey {
            case id, signatures, compression
            case packedContextFreeData = "packed_context_free_data"
            case contextFreeData = "context_free_data"
            case packedTrx = "packed_trx"
            case transaction
        }
    }
    
    struct TrxTransaction: Codable {
        let expiration: String?
        let refBlockNum, refBlockPrefix, maxNetUsageWords, maxCPUUsageMS: Int?
        let delaySEC: Int?
        let contextFreeActions: [String]?
        let actions: [Action]?
        
        enum CodingKeys: String, CodingKey {
            case expiration
            case refBlockNum = "ref_block_num"
            case refBlockPrefix = "ref_block_prefix"
            case maxNetUsageWords = "max_net_usage_words"
            case maxCPUUsageMS = "max_cpu_usage_ms"
            case delaySEC = "delay_sec"
            case contextFreeActions = "context_free_actions"
            case actions
        }
    }
    
    struct Action: Codable {
        let account: String?
        let name: String?
        let authorization: [Authorization]?
        let data: DataClass?
        let hexData: String?
        
        enum CodingKeys: String, CodingKey {
            case account, name, authorization, data
            case hexData = "hex_data"
        }
    }
    
    struct Authorization: Codable {
        let actor: String?
        let permission: String?
    }
    
    struct DataClass: Codable {
        let from: String?
        let to: String?
        let quantity: String?
        let memo: String?
    }
}





// MARK: Convenience initializers

extension BlockDataModel {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(BlockDataModel.self, from: data) else { return nil }
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

extension BlockDataModel.BlockDataModelTransaction {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(BlockDataModel.BlockDataModelTransaction.self, from: data) else { return nil }
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

extension BlockDataModel.Trx {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(BlockDataModel.Trx.self, from: data) else { return nil }
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

extension BlockDataModel.TrxTransaction {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(BlockDataModel.TrxTransaction.self, from: data) else { return nil }
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

extension BlockDataModel.Action {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(BlockDataModel.Action.self, from: data) else { return nil }
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

extension BlockDataModel.Authorization {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(BlockDataModel.Authorization.self, from: data) else { return nil }
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

extension BlockDataModel.DataClass {
    init?(data: Data) {
        guard let me = try? JSONDecoder().decode(BlockDataModel.DataClass.self, from: data) else { return nil }
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

