//
//  Authentications.swift
//  SecureZone
//
//  Created by Abdallahi Thiaw on 11/4/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class Authentications{
    static let db = Firestore.firestore()
    
    

    // creating error label
    static func errorLabel() -> UILabel {
        let errorLabel = UILabel()
        errorLabel.textColor = .red
        errorLabel.font = UIFont(name: SZ.Fonts.sf_semibold, size: 15)
        errorLabel.adjustsFontSizeToFitWidth = true
        errorLabel.numberOfLines = 0
        errorLabel.isHidden = true
        return errorLabel
    }
    
    // displaying error label
    static func showError(errorLabel: UILabel, message: String){
        errorLabel.isHidden = false
        errorLabel.textColor = .red
        errorLabel.text = message
    }
    
    
    // checking if pass contains atleast 8 chara with 1 letter & 1 numb
    static func isPasswordValid ( password : String, errorLabel: UILabel) -> Bool{
            let passwordTest = NSPredicate(format:
                                            "SELF MATCHES %@",
                                           "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$")
        if !passwordTest.evaluate(with: password){
            
            showError(errorLabel: errorLabel, message: "Please make sure your password atleast 8 characters contains 1 Alphabet and 1 Number.")
            return passwordTest.evaluate(with: password)
        }
        
            return passwordTest.evaluate(with: password)
        }
    
    // checking if textfields are empty
    static func isInputNotEmpty(inputs: [UITextField]) -> Bool{
            
            for input in inputs{
                if input.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
                    
                    Edits.inputError(input: input, errorText: "please fill in field")

                    return false
                }
            }
            return true
        }
    
    // checking if 2 password textfield match for signing up
    static func isPasswordMatch(textOne: UITextField, textTwo: UITextField, errorLabel: UILabel) -> Bool{
        if textOne.text == textTwo.text{
           return true
        }
        showError(errorLabel: errorLabel, message: "password textfields don't match")
        return false
    }
    
    // input data into firebase and check if data is duplicated.
    static func checkDouble(data: [String: String], accType: UITextField, type: String){
        if let userAccount = Auth.auth().currentUser?.email{
            let docRef = db.collection(userAccount).document(type)
            
            
            docRef.getDocument(source: .cache) { (document, error) in
                var double = true
                var AccType = accType.text!
                let count = 1
                
                while double {
                    if (document?.get(AccType)) != nil {
                        AccType = AccType+String(count)
                        double = true
                        
                    }else{
                        db.collection(userAccount).document(type).setData([AccType: data], merge: true)
                        double = false
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    // input data to firebase
    static func inputDataVerified(inputs:[UITextField], dataType: String, data1: UITextField, data2: UITextField, data3: UITextField,data4: String = "",data5: String = "",  inputView: UIView,  dataView: UITableView ) -> Bool{
        
        if Authentications.isInputNotEmpty(inputs: inputs){
            var data: [String:String] = [:]
            switch dataType{
            case SZ.FirebaseType.email:
                data = ["AccountType":data1.text!,
                        "Email": data2.text!,
                        "Password": data3.text!]
                
            case SZ.FirebaseType.code:
                data = ["CardType":data1.text!,
                        "CardNum": data2.text!,
                        "CardExp": data3.text!]
                
            case SZ.FirebaseType.creditCard:
                data = ["CardType":data1.text!,
                        "CardName": data2.text!,
                        "CardNum": data3.text!,
                        "CardExp": data4,
                        "CardCvv": data5]
                
                print(data3.text!.count)
                print(data4.count)
                print(data5.count)

                
            default:
                return false
            }
            
            Authentications.checkDouble(data: data, accType: data1, type: dataType)
            inputView.isHidden = true
            dataView.isHidden = false
            
            return true
        }
        return false
    }
  
    
    // check if credit card, ezpiration date, & CVV have enough characters
    
    static func validateCreds(creditCard: UITextField, cvv: UITextField, exp: UITextField)-> Bool{
        if creditCard.text!.count == 22{
            if cvv.text!.count == 3{
                if exp.text!.count == 5{
                    return true
                }else{
                    exp.text = ""
                    Edits.inputError(input: exp, errorText: "invalid format mm/yy")
                    return false
                }
                
            }else{
                cvv.text = ""
                Edits.inputError(input: cvv, errorText: "must be 3 numbers")
                return false
            }
        }else{
            creditCard.text = ""
            Edits.inputError(input: creditCard, errorText: "must be 16 Numbers")
            return false
        }
    }
    
    
    
    }
