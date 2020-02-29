//
//  BCRootViewController.swift
//  BlockChain
//
//  Created by prafull kumar on 29/2/20.
//  Copyright © 2020 prafull kumar. All rights reserved.
//

import UIKit

class BCRootViewController: UIViewController {

    lazy var errorView: BCErrorView = BCErrorView(delgate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
}

extension BCRootViewController: BCErrorViewDelegate {
    func retry() {
        errorView.hide()
    }
}
