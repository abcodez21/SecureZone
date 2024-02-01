//
//  CustomInputTextField.swift
//  SecureZone
//
//  Created by Abdallahi Thiaw on 10/27/23.
//

import UIKit
class CustomInputTextField: UITextField, UITextFieldDelegate {
    let padding: CGFloat = 20
    var placeHolderText: String
    
    init(placeHolderText: String) {
        self.placeHolderText = placeHolderText
        super.init(frame: .zero)
        initializeLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    
    func initializeLabel() {
        self.font = UIFont(name: SZ.Fonts.sf_light, size: 18)
        self.backgroundColor = .white
        self.textColor = UIColor(named: SZ.Colors.appColor)
      
        self.layer.cornerRadius = 40 / 2
        
        self.attributedPlaceholder = NSAttributedString(
            string: placeHolderText,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
      
        self.delegate = self


    }
    
    
    
    // fix layout
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let bounds = CGRect(x: self.padding, y: 0, width: bounds.width, height: bounds.height)
        return bounds
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let bounds = CGRect(x: self.padding, y: 0, width: bounds.width, height: bounds.height)
        return bounds
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let bounds = CGRect(x: self.padding, y: 0, width: bounds.width, height: bounds.height)
        return bounds
    }
}
