//
//  BCDetailViewModel.swift
//  BlockChain
//
//  Created by prafull kumar on 1/3/20.
//  Copyright © 2020 prafull kumar. All rights reserved.
//

import Foundation

protocol BCDetailViewPresenter {
    var title: String { get }
    var producer: String { get }
    var rawJson: String { get }
    var transactionCont: String { get }
    var signature: String { get }
}

final class BCDetailViewModel: BCDetailViewPresenter {
    private let dataModel: BlockDataModel
    required init(data: BlockDataModel) {
        dataModel = data
    }
    
    var title: String {
        return "\(dataModel.blockNum ?? 0)"
    }
    
    var producer: String {
        return dataModel.producer
    }
    
    var rawJson: String {
        return dataModel.json ?? "Json malformed"
    }
    
    var transactionCont: String {
        return "\(dataModel.transactions?.count ?? 0)"
    }
    
    var signature: String {
        return dataModel.producerSignature ?? "NA"
    }
    

}
