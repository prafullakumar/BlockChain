//
//  API.swift
//  MoviesDB
//
//  Created by prafull kumar on 2/2/20.
//  Copyright © 2020 prafull kumar. All rights reserved.
//
import Foundation
import Moya

enum Result<A> {
    case success(A)
    case failure(String)
}

typealias BlockInfoResult = Result<BlockInfo>
typealias BlockInfoResultCompletion = (BlockInfoResult) -> Void

typealias BlockDataModelResult = Result<BlockDataModel>
typealias BlockDataModelResultCompletion = (BlockDataModelResult) -> Void


enum BlockAPI {
    case info
    case block(blockId: String)
}

extension BlockAPI: TargetType {
    var baseURL: URL {
        guard let baseURL = URL.init(string: "https://api.eosnewyork.io/v1/chain") else {
            fatalError("Base URL Configuration Error")
        }
        return baseURL
    }
    
    var path: String {
        switch self {
        case .info:
            return "/get_info"
        case .block:
            return "/get_block"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .info:
            return .post
        case .block:
            return .post
        }
    }
    
    var sampleData: Data {
        switch self {
        case .info:
           return load(resource: "info")
        case .block:
           return load(resource: "block")
        }
    }
    
    private func load(resource: String) -> Data {
        if let filepath = Bundle.main.path(forResource: resource, ofType: "json") {
            return try! Data(contentsOf: URL(fileURLWithPath: filepath)) // stub shold crash on exection for better debugability
        } else {
            return Data()
        }
    }
    
    
    var task: Task {
        switch self {
        case .info:
            return .requestParameters(parameters: [:], encoding: JSONEncoding.default)
        case .block(let blockId):
            return .requestParameters(parameters: ["block_num_or_id": blockId], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
