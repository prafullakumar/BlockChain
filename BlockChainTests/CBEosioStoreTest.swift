//
//  CBEosioStoreTest.swift
//  BlockChainTests
//
//  Created by prafull kumar on 1/3/20.
//  Copyright © 2020 prafull kumar. All rights reserved.
//

import Foundation
import XCTest
import EosioSwift
@testable import BlockChain

class CBEosioStoreTest: XCTestCase {

    let provider = EosioRpcProvider(endpoint: URL(string: "https://api.eosnewyork.io")!)
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testInfo() {
        let store = BCEosioStore.init(provider: provider)
        let expectation = self.expectation(description: "Stub should work")
        store.getInfo { (result) in
            switch result {
            case .success:
                XCTAssert(true)
            case .failure:
                XCTAssert(false)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 45, handler: nil)
    }
    
    func testBlock() {
        let store = BCEosioStore.init(provider: provider)
        let expectation = self.expectation(description: "Stub should work")
        store.getBlock(blockId: "066d5ea6dc80d844c83b47396c47be178f679a001049ccc8f2c3cee1d90d9fdc") { (result) in
            switch result {
            case .success:
                XCTAssert(true)
            case .failure:
                XCTAssert(false)
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 45, handler: nil)
    }

}
