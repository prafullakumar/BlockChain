//
//  BCDetailViewControllerTest.swift
//  BlockChainTests
//
//  Created by prafull kumar on 1/3/20.
//  Copyright © 2020 prafull kumar. All rights reserved.
//

import XCTest
import FBSnapshotTestCase
import Moya
@testable import BlockChain

class BCDetailViewControllerTest: FBSnapshotTestCase {
    
    override func setUp() {
        super.setUp()
        recordMode = false
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDetailViewController() {
        let vc = BCDetailViewController()
        vc.viewPresenter = BCDetailViewModel.init(data: genrateMockData())
        FBSnapshotVerifyView(vc.view)
    }
    
    
    private func genrateMockData() -> BlockDataModel {
        return BlockDataModel(data: load(resource: "block"))!
    }
    
    
    private func load(resource: String) -> Data {
        if let filepath = Bundle.main.path(forResource: resource, ofType: "json") {
            return try! Data(contentsOf: URL(fileURLWithPath: filepath)) // stub shold crash on exection for better debugability
        } else {
            return Data()
        }
    }
}

