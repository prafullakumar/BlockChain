//
//  BCEntryViewModel.swift
//  BlockChain
//
//  Created by prafull kumar on 29/2/20.
//  Copyright © 2020 prafull kumar. All rights reserved.
//

import Foundation


enum ViewModelState {
    case loading(String)
    case loadSuccess
    case loadFail(String)
    case unknown
}


protocol BCEntryViewPresenter: class {
    var title: String { get }
    var buttonTitle: String { get }
    var status: String { get }
    var delegate: ViewControllerUpdateDelegate? { get }
    var hasBlockCollection: Bool { get }
    func fetchLatestBlocks()
}

protocol  ViewControllerUpdateDelegate: class {
    func viewModel(didUpdateState state: ViewModelState)
}


final class BCEntryViewModel: BCEntryViewPresenter {
    weak var delegate: ViewControllerUpdateDelegate?
    var dataModel: [BlockDataModel] = []
    
    var info: BlockInfo?
    
    private let store: BCStore
    private let maxBlock = 20
    private var state: ViewModelState = .unknown {
        didSet {
            delegate?.viewModel(didUpdateState: state)
        }
    }
    
    var title: String {
        return "BlocIO"
    }
    
    var hasBlockCollection: Bool {
        return dataModel.count != 0
    }
        
    var buttonTitle: String {
        switch state {
        case .loadSuccess:
            return ""
        case .loadFail:
            return "Tap to Retry"
        case .loading:
            return "Retrieving Data..."
        default:
            return "Tap to Explore"
        }
    }
        
    var status: String {
        switch state {
        case .loadSuccess:
            return ""
        case .loadFail(let error):
            return error
        case .loading(let status):
            return status
        default:
            return ""
        }
    }
    
    
    required init(networking: Networking, delgate: ViewControllerUpdateDelegate) {
        self.delegate = delgate
        self.store = BCStore(networking: networking)
    }
    
    func fetchLatestBlocks() {
        switch state {
        case .loading:
            return
        default:
            state = .loading(getLoadingMessage())
            fetchInfo()
        }
    }
    
    private func fetchInfo() {
        store.getInfo { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.info = data
                self.fetchBlocks()
            case .failure(let error):
                self.state = .loadFail(error)
            }
        }
    }
    
    private func fetchBlocks(){
        guard dataModel.count < maxBlock else {
            self.state = .loadSuccess
            return
        }
        
        guard let blockId = dataModel.last?.previous ?? info?.headBlockID else {
            self.state = .loadFail("No valid block found.")
            return
        }
        
        store.getBlock(blockId: blockId) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.dataModel.append(data)
                self.state = .loading(self.getLoadingMessage())
                self.fetchBlocks()
            case .failure(let error):
                self.state = .loadFail(error)
            }
        }
    }
    
    private func getLoadingMessage() -> String {
        return "\(self.dataModel.count)/\(self.maxBlock) Downloaded"
    }
}
