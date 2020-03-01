//
//  BlockInfo.swift
//  BlockChain
//
//  Created by prafull kumar on 29/2/20.
//  Copyright © 2020 prafull kumar. All rights reserved.
//

import Foundation

struct BlockInfo: Codable {
    let serverVersion, chainID: String
    let headBlockNum, lastIrreversibleBlockNum: Int
    let lastIrreversibleBlockID, headBlockID, headBlockTime, headBlockProducer: String
    let virtualBlockCPULimit, virtualBlockNetLimit, blockCPULimit, blockNetLimit: Int
    let serverVersionString: String
    let forkDBHeadBlockNum: Int
    let forkDBHeadBlockID, serverFullVersionString: String

    enum CodingKeys: String, CodingKey {
        case serverVersion = "server_version"
        case chainID = "chain_id"
        case headBlockNum = "head_block_num"
        case lastIrreversibleBlockNum = "last_irreversible_block_num"
        case lastIrreversibleBlockID = "last_irreversible_block_id"
        case headBlockID = "head_block_id"
        case headBlockTime = "head_block_time"
        case headBlockProducer = "head_block_producer"
        case virtualBlockCPULimit = "virtual_block_cpu_limit"
        case virtualBlockNetLimit = "virtual_block_net_limit"
        case blockCPULimit = "block_cpu_limit"
        case blockNetLimit = "block_net_limit"
        case serverVersionString = "server_version_string"
        case forkDBHeadBlockNum = "fork_db_head_block_num"
        case forkDBHeadBlockID = "fork_db_head_block_id"
        case serverFullVersionString = "server_full_version_string"
    }
}

// MARK: Convenience initializers

extension BlockInfo {
    init?(data: Data) {
        do {
            self = try JSONDecoder().decode(BlockInfo.self, from: data)
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
