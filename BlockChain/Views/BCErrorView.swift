//
//  BCErrorView.swift
//  BlockChain
//
//  Created by prafull kumar on 29/2/20.
//  Copyright © 2020 prafull kumar. All rights reserved.
//

import UIKit

struct ErrorDataModel {
    let buttonTitle: String
    let errorMessage: String
}

protocol BCErrorViewDelegate: class {
    func retry()
}

class BCErrorView: UIView {
    private let padding: CGFloat = 16.0
    private let buttonHeight: CGFloat = 45
    private weak var delegate: BCErrorViewDelegate?
    private var errorMessage: String? {
        didSet {
            errorMessageLabel.text  = errorMessage
        }
    }
    
    private var  buttonTitle: String? {
        didSet {
            button.setTitle(buttonTitle, for: .normal)
        }
    }
    
    init(delgate: BCErrorViewDelegate?) {
        self.delegate = delgate
        super.init(frame: CGRect.zero)
    }
    
    private lazy var errorMessageLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        return textLabel
    }()
    
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(onTap), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: buttonHeight)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.contentEdgeInsets = UIEdgeInsets(top: padding/2, left: padding, bottom: padding/2, right: padding)
        button.makeRoundedCorner(borderColor: UIColor.blue.cgColor, radius: padding/2)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing   = padding
        stackView.addArrangedSubview(errorMessageLabel)
        stackView.addArrangedSubview(button)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -1 * padding).isActive = true
        
        return stackView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(in view: UIView, with errorData: ErrorDataModel) {
        errorMessage = errorData.errorMessage
        buttonTitle = errorData.buttonTitle
        
        if self.superview == nil {
            view.addSubview(self)
            self.bindFrameTo(view: view)
            _ = stackView
        } 
        
    }
    
    @objc func onTap() {
        delegate?.retry()
    }
    
    func hide() {
        self.removeFromSuperview()
    }
    
}
