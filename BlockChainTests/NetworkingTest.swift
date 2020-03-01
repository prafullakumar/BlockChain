//
//  NetworkingTest.swift
//  BlockChainTests
//
//  Created by prafull kumar on 1/3/20.
//  Copyright © 2020 prafull kumar. All rights reserved.
//

import Foundation
import XCTest
import Moya
@testable import BlockChain

class NetworkingTest: XCTestCase {
    
    
    let networking = Networking.init(provider: MoyaProvider<BlockAPI>())
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAPIFail() {
        let expectation = self.expectation(description: "Api should fail")
        networking.block(blockId: "invalid Block Id") { (result) in
            switch result {
            case .success:
                XCTAssert(false)
            case .failure:
                XCTAssert(true)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 45, handler: nil)
    }
    
    func testInfoAPISuccess() {
        let expectation = self.expectation(description: "Api should pass")
        networking.blockInfo { (result) in
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
    
    
    func testBlockAPISuccess() {
        let expectation = self.expectation(description: "Api should pass")
        networking.block(blockId: "066d5d5972ff4810ab57f7eed422a812688aba5e96b7607c76ae03827d47cbab") { (result) in
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
