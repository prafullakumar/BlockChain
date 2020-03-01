//
//  BCListControllerTest.swift
//  BlockChainTests
//
//  Created by prafull kumar on 1/3/20.
//  Copyright © 2020 prafull kumar. All rights reserved.
//

import XCTest
import FBSnapshotTestCase
import Moya
@testable import BlockChain

class BCListControllerTest: FBSnapshotTestCase {
    
    
    
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testListViewController() {
        
        let vc = BCListViewController()
        let store = BCNetworkingStore.init(networking: Networking.init(provider: MoyaProvider<BlockAPI>()))
        vc.viewPresenter = BCListViewModel(dataModel: genrateMockData(),
                                           store: store,
                                           delegate: vc)
        
        FBSnapshotVerifyView(vc.view)
    }
    
    
    func genrateMockData() -> [BlockDataModel] {
        var dataArray:  [BlockDataModel]  = []
        for _ in 0...19 {
            dataArray.append(BlockDataModel(data: load(resource: "block"))!)
        }
        return dataArray
    }
    
    
    private func load(resource: String) -> Data {
        if let filepath = Bundle.main.path(forResource: resource, ofType: "json") {
            return try! Data(contentsOf: URL(fileURLWithPath: filepath)) // stub shold crash on exection for better debugability
        } else {
            return Data()
        }
    }
}

