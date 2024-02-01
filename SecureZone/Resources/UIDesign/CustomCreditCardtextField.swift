//
//  CustomCreditCardtextField.swift
//  SecureZone
//
//  Created by Abdallahi Thiaw on 1/31/24.
//

import UIKit
class CustomCreditCardtextField: CustomInputTextField {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if string == ""{
            return true
        }
        
        //range.length will be greater than 0 if user is deleting text - allow it to replace
        if range.length > 0
        {
            return true
        }
        
        //Don't allow empty strings
        if string == "-"
        {
            return false
        }
        
        //Check for max length including the spacers we added
        if range.location > 21
        {
            return false
        }
        
        var originalText = textField.text
        let replacementText = string.replacingOccurrences(of: "-", with: "")
        
        //Verify entered text is a numeric value
        let digits = NSCharacterSet.decimalDigits
        for char in replacementText.unicodeScalars
        {
            if !(digits as NSCharacterSet).longCharacterIsMember(char.value)
            {
                return false
            }
        }
        
        //Put an empty space after every 4 places
        if (originalText?.count)! > 0
        {
            if (originalText?.count)! < 5 && (originalText?.count)! % 4 == 0{
                originalText?.append("  ")
            }else if(originalText?.count == 5 || originalText?.count == 10 || originalText?.count == 16){
                originalText?.append("  ")

            }
            
        }
        
        textField.text = originalText
        
        return true
    }
}
