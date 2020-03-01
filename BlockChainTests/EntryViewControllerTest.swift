//
//  EntryViewControllerTest.swift
//  BlockChainTests
//
//  Created by prafull kumar on 1/3/20.
//  Copyright © 2020 prafull kumar. All rights reserved.
//

import XCTest
import FBSnapshotTestCase
import Moya
@testable import BlockChain

class EntryViewControllerTest: FBSnapshotTestCase {
    
    
    
    override func setUp() {
        super.setUp()
        recordMode = false
    }

    override func tearDown() {
        super.tearDown()
    }

    func testEntryViewController() {
        
        let entryViewController = BCEntryViewController()
        
        // switch between store to use API or EosioSwift Pod
        let store = BCNetworkingStore.init(networking: Networking.init(provider: MoyaProvider<BlockAPI>()))
        
        entryViewController.viewPresenter  = BCEntryViewModel(store: store, delgate: entryViewController)
        
        FBSnapshotVerifyView(entryViewController.view)
    }
    
    func testEntryViewButtonTappedController() {
        
        let entryViewController = BCEntryViewController()
        
        // switch between store to use API or EosioSwift Pod
        let store = BCNetworkingStore.init(networking: Networking.init(provider: MoyaProvider<BlockAPI>()))
        
        entryViewController.viewPresenter  = BCEntryViewModel(store: store, delgate: entryViewController)
        
        entryViewController.onTap()
        
        FBSnapshotVerifyView(entryViewController.view)
    }

}

