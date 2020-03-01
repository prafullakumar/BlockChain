//
//  BCEntryViewController.swift
//  BlockChain
//
//  Created by prafull kumar on 29/2/20.
//  Copyright © 2020 prafull kumar. All rights reserved.
//

import UIKit

final class BCEntryViewController: UIViewController {
    
    private let buttonHeight: CGFloat = 200.0
    private let buttonWidth: CGFloat = 200.0
    private let padding: CGFloat = 16.0
    
    var viewPresenter: BCEntryViewPresenter!
    
    private lazy var statusLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        return textLabel
    }()
    
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(onTap), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        button.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.contentEdgeInsets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        button.backgroundColor = .blue
        button.makeRoundedCorner(with: buttonHeight/2)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = padding
        stackView.addArrangedSubview(button)
        stackView.addArrangedSubview(statusLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: padding).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -1 * padding).isActive = true
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    private func setupUI() {
        self.updateView()
        self.view.backgroundColor = .white
        _ = stackView //load stack view
        animateButton()
    }
    
    private func updateView() {
        self.title = viewPresenter.title
        self.button.setTitle(viewPresenter.buttonTitle, for: .normal)
        self.statusLabel.text = viewPresenter.status
    }
    
    private func animateButton() {
        let pulseAnimation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        pulseAnimation.duration = 1
        pulseAnimation.fromValue = 0.5
        pulseAnimation.toValue = 1
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .greatestFiniteMagnitude
        button.layer.add(pulseAnimation, forKey: "animateOpacity")
    }

    @objc func onTap() {
        viewPresenter.fetchLatestBlocks()
    }

}


extension BCEntryViewController: ViewControllerUpdateDelegate {
    func viewModel(didUpdateState state: ViewModelState) {
        //also, can render a new view on the first block and keep updating table view cell, As I am implementing pull to refresh on a new page, which also conveyed same logic so not making this flow
        switch state {
        case .loadSuccess:
            //show detail view
            showBlockList()
        case .loadFail:
            //if have some data show the list
            viewPresenter.hasBlockCollection ? showBlockList() : updateView()
        default:
            updateView()
        }
    }
    
    private func showBlockList() {
        let vc = BCListViewController()
        vc.viewPresenter = BCListViewModel(dataModel: viewPresenter.dataModel,
                                           store: viewPresenter.store,
                                           delegate: vc)
        self.navigationController?.setViewControllers([vc], animated: false)
    }
}
