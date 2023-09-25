//
//  UITextField.swift
//  ReadersProject
//
//  Created by Анна Иванова on 25.09.2023.
//

import UIKit

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setAppearence() {
        self.overrideUserInterfaceStyle = .light
        self.borderStyle = .none
        self.layer.cornerRadius = 12
        self.backgroundColor = .white
        self.setLeftPaddingPoints(16)
    }
}
