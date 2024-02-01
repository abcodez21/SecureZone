//
//  CustomCvvTextField.swift
//  SecureZone
//
//  Created by Abdallahi Thiaw on 1/31/24.
//

import UIKit
class CustomCvvTextField: CustomInputTextField {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if range.length > 0 {
            return true
        }
        if string == "" {
            return false
        }
        if range.location > 2 {
            return false
        }
        let originalText = textField.text
        let replacementText = string.replacingOccurrences(of: " ", with: "")
        
        //Verify entered text is a numeric value
        if !CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: replacementText)) {
            return false
        }
        textField.text = originalText
        
        return true
    }
}
