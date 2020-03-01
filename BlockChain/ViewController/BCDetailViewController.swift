//
//  BCDetailViewController.swift
//  BlockChain
//
//  Created by prafull kumar on 1/3/20.
//  Copyright © 2020 prafull kumar. All rights reserved.
//

import UIKit

final class BCDetailViewController: UIViewController {
    
    var viewPresenter: BCDetailViewPresenter!
    
    enum ViewType: Int {
        case hide
        case show
        
        var stringRepresentation: String {
            switch self {
            case .hide:
                return "Hide Json"
            case .show:
                return "Show Json"
            }
        }
    }
    
    
    lazy var scrollableStackView: ScrollableStackView = {
        let scrollableStackView = ScrollableStackView.init(frame: CGRect.zero)
        self.view.addSubview(scrollableStackView)
        scrollableStackView.stackView.distribution = .fillProportionally
        scrollableStackView.stackView.alignment = .center
        scrollableStackView.scrollView.showsVerticalScrollIndicator = false
        scrollableStackView.scrollView.alwaysBounceVertical = false
        scrollableStackView.bindFrameTo(view: self.view, padding: ScrollableStackView.Constants.padding)
        scrollableStackView.scrollView.contentInset = UIEdgeInsets(top: ScrollableStackView.Constants.padding, left: 0, bottom: 0, right: 0)
        return scrollableStackView
    }()
    
    
    var rawJsonTextView: UITextView?
    
    lazy var segmentControll: UISegmentedControl = {
        let segment = UISegmentedControl(items: [ViewType.hide.stringRepresentation, ViewType.show.stringRepresentation])
        segment.addTarget(self, action: #selector(onChange), for: .valueChanged)
        segment.sizeToFit()
        segment.selectedSegmentIndex = 0
        return segment
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()

        
    }
    
    
    private func setupUI() {
        self.view.backgroundColor = .white
        self.title = viewPresenter.title
        scrollableStackView.loadLabel(withString: "producer: \(viewPresenter.producer)",  font: UIFont.systemFont(ofSize: 18, weight: .bold))
        scrollableStackView.loadLabel(withString: "transactions: \(viewPresenter.transactionCont)",  font: UIFont.systemFont(ofSize: 18, weight: .bold))
        scrollableStackView.loadLabel(withString: "producer signature:",  font: UIFont.systemFont(ofSize: 18, weight: .bold))
        scrollableStackView.loadLabel(withString: viewPresenter.signature)
        scrollableStackView.loadView(view: self.segmentControll)
        
        //too big json - moving feth op to background
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            let data = self.viewPresenter.rawJson
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.rawJsonTextView = self.scrollableStackView.loadTextView(withString: data)
                self.onChange()
            }
        }
        
      
    }
    
    
    
    @objc func onChange() {
        switch ViewType.init(rawValue: segmentControll.selectedSegmentIndex) {
        case .hide?:
            rawJsonTextView?.isHidden = true
        case .show?:
            rawJsonTextView?.isHidden = false
        case .none:
            break;
        }
    }
}
