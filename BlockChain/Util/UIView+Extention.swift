//
//  UIView+Extention
//  BlockChain
//
//  Created by prafull kumar on 29/2/20.
//  Copyright © 2020 prafull kumar. All rights reserved.
//

import UIKit

//Autolayout
extension UIView {
    func bindFrameTo(view:UIView, padding: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: view.topAnchor, constant: padding).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -1 * padding).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1 * padding).isActive = true
    }
    
}


//MARK: - RoundedCorners
extension UIView{
    func makeRoundedCorner() {
        makeRoundedCorner(with: self.frame.size.height / 2.0)
        self.clipsToBounds = true
    }
    
    func makeRoundedCorner(with radius:CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    func makeRoundedCorner(fillColor: CGColor) {
        self.layer.backgroundColor = fillColor
        self.makeRoundedCorner()
    }
    
    func makeRoundedCorner(borderColor: CGColor?, borderWidth: CGFloat = 1){
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
        self.makeRoundedCorner()
    }
    
    func makeRoundedCorner(borderColor: CGColor?, borderWidth: CGFloat = 1, radius: CGFloat){
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
        makeRoundedCorner(with: radius)
    }
    
    func roundCorner(corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
    
}
