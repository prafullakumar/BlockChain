//
//  ScrollableStackView.swift
//  BlockChain
//
//  Created by prafull kumar on 29/2/20.
//  Copyright © 2020 prafull kumar. All rights reserved.
//

import UIKit

// can be done by XIB.. this is to demostrate view via code
final class ScrollableStackView: UIView {
    
    struct Constants {
        static let topPadding: CGFloat = 18
        static let textPaddingToBorder: CGFloat = 25
        static let imagePaddingToBorder: CGFloat = 15
        static let buttonPaddingToBorder: CGFloat = 25
        static let buttonPaddingToBottom: CGFloat = 30
        static let defaultFontSize: CGFloat = 14
        static let buttonTextInsets = UIEdgeInsets(top: 10, left: 25, bottom: 10, right: 25)
        static let compareViewHeight: CGFloat = 95
    }
    
    fileprivate var didSetupConstraints = false
    final var spacing: CGFloat = 25
    
    public lazy var scrollView: UIScrollView = {
        let instance = UIScrollView(frame: CGRect.zero)
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.layoutMargins = .zero
        return instance
    }()
    
    public lazy var stackView: UIStackView = {
        let instance = UIStackView(frame: CGRect.zero)
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.axis = .vertical
        instance.spacing = self.spacing
        instance.distribution = .equalSpacing
        return instance
    }()
    
    //MARK: View life cycle
    override public func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupUI()
    }
    
    //MARK: UI
    func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        addSubview(scrollView)
        scrollView.addSubview(stackView)
        setNeedsUpdateConstraints() // Bootstrap auto layout
    }
    
    override public func updateConstraints() {
        super.updateConstraints()
        if !didSetupConstraints {
            scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            didSetupConstraints = true
        }
    }
    
    func removeAllArrangedSubviews() {
        let removedSubviews = stackView.arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            stackView.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
    
}

//Mark - ADD Views
extension ScrollableStackView {
    
    public func loadLabel(withString text: String, padding: CGFloat = Constants.textPaddingToBorder,
                          font: UIFont = UIFont.systemFont(ofSize: 14),
                          textAlignment: NSTextAlignment = .left) {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = font
        label.text = text
        label.textAlignment = textAlignment
        label.textColor = UIColor.black
        let textWidth = UIScreen.main.bounds.size.width - padding*2
        let size = label.sizeThatFits(CGSize(width: textWidth, height: CGFloat.greatestFiniteMagnitude))
        label.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        label.widthAnchor.constraint(equalToConstant: textWidth).isActive = true
        self.stackView.addArrangedSubview(label)
    }
}
