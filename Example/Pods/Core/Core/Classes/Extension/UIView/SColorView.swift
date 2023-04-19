//
//  SColorView.swift
//  Core
//
//  Created by HU-IOS-DT-QUAN on 19/04/2023.
//

import Foundation
import UIKit

extension UIView{
    @objc public var sccard: Bool {
        get{false}
        set {
            addCardShadow()
        }
    }
    
    public func addCardShadow(){
        layer.cornerRadius = 10
         
        // border
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.black.withAlphaComponent(0.2).cgColor
         
        // shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 2.0
        
    }
}
