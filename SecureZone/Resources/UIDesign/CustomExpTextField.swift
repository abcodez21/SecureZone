import UIKit
class CustomExpTextField: CustomInputTextField {
    
    
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
         
             if range.length > 0 {
                 return true
             }
             if string == "" {
                 return false
             }
             if range.location > 4 {
                 return false
             }
             var originalText = textField.text
             let replacementText = string.replacingOccurrences(of: " ", with: "")
             
             //Verify entered text is a numeric value
             if !CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: replacementText)) {
                 return false
             }
             
             //Put / after 2 digit
             if range.location == 2 {
                 originalText?.append("/")
                 textField.text = originalText
             }
             return true
         }
    }
    

