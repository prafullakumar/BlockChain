//
//  BCEosioStore.swift
//  BlockChain
//
//  Created by prafull kumar on 1/3/20.
//  Copyright © 2020 prafull kumar. All rights reserved.
//

import Foundation
import EosioSwift

final class BCEosioStore: BCStoreProtocol {
    let  rpcProvider: EosioRpcProvider
    
    init(provider: EosioRpcProvider) {
        rpcProvider = provider
    }
    
    func getInfo(completion: @escaping BlockInfoResultCompletion) {
        //Workaround due to ambiguous call back
        let callback: ((EosioResult<EosioRpcInfoResponse, EosioError>) -> Void) = { (infoResponse) in
            switch infoResponse {
            case .failure(let error):
                completion(.failure(error.localizedDescription))
            case .success(let info):
                
                let data = try? JSONSerialization.data(withJSONObject: info._rawResponse ?? [:], options: .prettyPrinted)
                if let baseModel = BlockInfo(data: data ?? Data())  {
                    completion(.success(baseModel))
                } else {
                    completion(.failure(Networking.parsingErrorMessage))
                }
            }
        }
        
        rpcProvider.getInfo(completion: callback)
    }
    
    func getBlock(blockId: String, completion: @escaping BlockDataModelResultCompletion) {
        //Workaround due to ambiguous call back
        let callback: ((EosioResult<EosioRpcBlockResponse, EosioError>) -> Void) = { (infoResponse) in
            switch infoResponse {
            case .failure(let error):
                completion(.failure(error.localizedDescription))
            case .success(let info):
                
                let data = try? JSONSerialization.data(withJSONObject: info._rawResponse ?? [:], options: .prettyPrinted)
                if let baseModel = BlockDataModel(data: data ?? Data())  {
                    completion(.success(baseModel))
                } else {
                    completion(.failure(Networking.parsingErrorMessage))
                }
            }
        }
        
        rpcProvider.getBlock(requestParameters: EosioRpcBlockRequest.init(blockNumOrId: blockId), completion: callback)
    }
}
