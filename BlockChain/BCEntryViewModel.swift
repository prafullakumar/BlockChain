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
    case loadFail(Error)
    case unknown
}


protocol BCEntryViewPresenter: class {
    var title: String { get }
    var buttonTitle: String { get }
    var status: String { get }
    var delegate: ViewControllerUpdateDelegate? { get }
    func fetchLatestBlocks()
}

protocol  ViewControllerUpdateDelegate: class {
    func viewModel(didUpdateState state: ViewModelState)
}


final class BCEntryViewModel: BCEntryViewPresenter {
    weak var delegate: ViewControllerUpdateDelegate?
    private let maxBlock = 20
    private var state: ViewModelState = .unknown {
        didSet {
            delegate?.viewModel(didUpdateState: state)
        }
    }
    
    var title: String {
        return "BlocIO"
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
            return error.localizedDescription
        case .loading(let status):
            return status
        default:
            return ""
        }
    }
    
    
    required init(delgate: ViewControllerUpdateDelegate) {
        self.delegate = delgate
    }
    
    func fetchLatestBlocks() {
        switch state {
        case .loading:
            return
        default:
            state = .loading("0/\(maxBlock) Downloaded")
//            store.fetchNextPage { (result) in
//                switch result {
//                case .success(let data):
//                    self.dataModel.append(contentsOf: data)
//                    self.state = .loadSuccess
//                case .failure(let error):
//                    self.state = .loadFail(error)
//                }
//            }
        }
    }
}
