//
//  BCListViewModel.swift
//  BlockChain
//
//  Created by prafull kumar on 29/2/20.
//  Copyright © 2020 prafull kumar. All rights reserved.
//

import UIKit

protocol BCListViewPresenter: class {
    var cellCount: Int { get }
    var title: String { get }
    func cellDataModel(index: Int) -> CellDatamodel
    func cellData(index: Int) -> BlockDataModel
    func refresh()
}


struct CellDatamodel {
    let identifier: String
    let producer: String
}

final class BCListViewModel: BCListViewPresenter {
    
    private var state: ViewModelState = .unknown {
        didSet {
            delegate?.viewModel(didUpdateState: state)
        }
    }
    
    var cellCount: Int {
        return dataModel.count
    }
    
    var title: String {
        return "Recent blocks"
    }
    
    var isfooterVisible: Bool {
        return (dataModel.count < maxBlock) && (dataModel.last?.previous != nil) //show foter retry if failed to get 20 blocks
    }
    
    func cellDataModel(index: Int) -> CellDatamodel {
        let data = dataModel[index]
        return CellDatamodel(identifier: data.id, producer: data.producer)
    }
    
    func cellData(index: Int) -> BlockDataModel {
        return dataModel[index]
    }
    
    var dataModel: [BlockDataModel]
    var axillaryDataModel: [BlockDataModel] = []
    let store: BCStore
    weak var delegate: ViewControllerUpdateDelegate?
    
    init(dataModel: [BlockDataModel],
         store: BCStore,
         delegate: ViewControllerUpdateDelegate?) {
        
        self.dataModel = dataModel
        self.store = store
        self.delegate = delegate
    }
    
    func refresh() {
        switch state {
        case .loading:
            return
        default:
            state = .loading("")
            fetchInfo()
        }
    }
    
    private func fetchInfo() {
        store.getInfo { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                if (data.headBlockID == self.dataModel.first?.id) && self.dataModel.count == maxBlock {
                    self.state = .loadSuccess //alreday have latest Blocks, no need to load again
                } else {
                    self.fetchBlock(id: data.headBlockID)
                }
                
            case .failure(let error):
                self.state = .loadFail(error)
            }
        }
    }
    
    private func fetchBlock(id: String){
        store.getBlock(blockId: id) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                if data.previous == self.dataModel.first?.id { //link found no need to fetch more update list
                    self.dataModel.insert(data, at: 0)
                    if self.dataModel.count > maxBlock {
                        self.dataModel.removeLast()
                    }
                    self.state = .loadSuccess
                } else if self.axillaryDataModel.count == (maxBlock - 1 ) {
                    self.axillaryDataModel.append(data)
                    self.dataModel = self.axillaryDataModel
                    self.axillaryDataModel = []
                    self.state = .loadSuccess
                } else {
                    self.axillaryDataModel.append(data)
                    self.fetchBlock(id: data.previous ?? "")
                    self.state = .loading("")
                }
            case .failure(let error):
                //update block with axillary array
                self.dataModel = self.axillaryDataModel
                self.axillaryDataModel = []
                self.state = .loadFail(error)
            }
        }
    }
}
