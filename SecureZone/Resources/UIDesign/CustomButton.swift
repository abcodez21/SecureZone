//
//  CustomButton.swift
//  SecureZone
//
//  Created by Abdallahi Thiaw on 10/26/23.
//

import UIKit

class CustomButton: UIButton {
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeLabel()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeLabel()
    }
    
    func initializeLabel() {
        self.backgroundColor = UIColor(named: SZ.Colors.appColor)
        self.layer.cornerRadius = 53 / 2
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.titleLabel?.font =  UIFont(name: SZ.Fonts.sf_light, size: 25)
    }
}
