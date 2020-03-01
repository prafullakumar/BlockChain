//
//  AppDelegate.swift
//  BlockChain
//
//  Created by prafull kumar on 29/2/20.
//  Copyright © 2020 prafull kumar. All rights reserved.
//

import UIKit
import Moya

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        let entryViewController = BCEntryViewController()
        
        // switch between store to use API or EosioSwift Pod  
        let store = BCNetworkingStore.init(networking: Networking.init(provider: MoyaProvider<BlockAPI>()))
        
        entryViewController.viewPresenter  = BCEntryViewModel(store: store, delgate: entryViewController)
        window?.rootViewController = UINavigationController.init(rootViewController: entryViewController)
        window?.makeKeyAndVisible()
        return true
    }

}

