//
//  Networking.swift
//  BlockChain
//
//  Created by prafull kumar on 29/2/20.
//  Copyright © 2020 prafull kumar. All rights reserved.
//

import Foundation
import Moya

protocol NetworkProtocol {
    func blockInfo(completion: @escaping BlockInfoResultCompletion)
    func block(blockId: String, completion: @escaping BlockDataModelResultCompletion)
}

final class Networking: NetworkProtocol {
    
    static let parsingErrorMessage = "Error Parsing Object"
    
    let provider: MoyaProvider<BlockAPI>
    
    required init(provider: MoyaProvider<BlockAPI>) {
        self.provider = provider
    }
    
    func blockInfo(completion: @escaping BlockInfoResultCompletion) {
        provider.request(BlockAPI.info) { (result) in
            switch result {
            case .success(let response):
                if 200..<300 ~= response.statusCode {
                    if let baseModel = BlockInfo(data: response.data)  {
                        completion(.success(baseModel))
                    } else {
                        completion(.failure(Networking.parsingErrorMessage))
                    }
                } else {
                    let baseModel = ErrorDataModel(data: response.data)
                    completion(.failure(baseModel?.message ?? Networking.parsingErrorMessage))
                }
            case .failure(let error):
                completion(.failure(error.localizedDescription))
            }
        }
    }
    
    func block(blockId: String, completion: @escaping BlockDataModelResultCompletion) {
        provider.request(BlockAPI.block(blockId: blockId)) { (result) in
            switch result {
            case .success(let response):
                if 200..<300 ~= response.statusCode {
                    if let baseModel = BlockDataModel(data: response.data)  {
                        completion(.success(baseModel))
                    } else {
                        completion(.failure(Networking.parsingErrorMessage))
                    }
                } else {
                    let baseModel = ErrorDataModel(data: response.data)
                    completion(.failure(baseModel?.message ?? Networking.parsingErrorMessage))
                }
            case .failure(let error):
                completion(.failure(error.localizedDescription))
            }
        }
    }
    
}



