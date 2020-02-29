//
//  BCStore.swift
//  BlockChain
//
//  Created by prafull kumar on 29/2/20.
//  Copyright © 2020 prafull kumar. All rights reserved.
//

import Foundation
import Moya

final class BCStore {

    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func getInfo(completion : @escaping BlockInfoResultCompletion) {
        self.networking.blockInfo(completion: completion)
    }
    
    func getBlock(blockId: String, completion : @escaping BlockDataModelResultCompletion) {
        self.networking.block(blockId: blockId, completion: completion)
    }
    
}
