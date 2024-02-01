//
//  SZForgotPassword.swift
//  SecureZone
//
//  Created by Abdallahi Thiaw on 10/13/23.
//

import UIKit
import FirebaseAuth

class SZForgotPassword: UIViewController {

    let appName = Edits.lableEdit(labelColor: .white, labelText: "Secure Zone", fontName: SZ.Fonts.sf_Regular, fontSize: 37)
    
    let resetPasswordLabel = Edits.lableEdit(labelColor: .white, labelText: "Reset Password", fontName: SZ.Fonts.sf_light, fontSize: 25)
    
    let curveImage = Edits.addImg(imgName: SZ.Img.curlyImg)
    let emailInput = Edits.textField(placeHolderText: "Email Address", color: UIColor(named: SZ.Colors.appColor)!)
    
    let resetPasswordBtn = CustomButton()
    
    let backBtn = UIButton()
    
    let errorLabel = Authentications.errorLabel()

    


    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        constrains()

        
    }
    

    func constrains(){
        self.view.addSubview(appName)
        self.view.addSubview(curveImage)
        self.view.addSubview(resetPasswordLabel)
        self.view.addSubview(backBtn)
        
        self.view.addSubview(errorLabel)
        self.view.addSubview(emailInput)
        self.view.addSubview(resetPasswordBtn)
        self.view.addSubview(backBtn)

        
        appName.translatesAutoresizingMaskIntoConstraints = false
        curveImage.translatesAutoresizingMaskIntoConstraints = false
        resetPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
        
        emailInput.translatesAutoresizingMaskIntoConstraints = false
        resetPasswordBtn.translatesAutoresizingMaskIntoConstraints = false
        backBtn.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        appName.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        appName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        
        backBtn.centerYAnchor.constraint(equalTo: appName
            .safeAreaLayoutGuide.centerYAnchor).isActive = true
        backBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  10).isActive = true
//        appName.frame = CGRect.init(x: 154, y: 100, width: 180, height: 45)
//        curveImage.frame = CGRect(x: 16, y: 252, width: 348, height: 348)
        curveImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        curveImage.topAnchor.constraint(equalTo: appName.bottomAnchor, constant: 70).isActive = true
        curveImage.heightAnchor.constraint(equalToConstant:400).isActive = true
        curveImage.widthAnchor.constraint(equalToConstant: 365).isActive = true

//        loginLabel.frame = CGRect(x: 275, y: 251, width: 74, height: 37)
        resetPasswordLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -25).isActive = true
        resetPasswordLabel.bottomAnchor.constraint(equalTo: curveImage.topAnchor, constant: 35).isActive = true
        
//        emailInput.centerXAnchor.constraint(equalTo: curveImage.safeAreaLayoutGuide.centerXAnchor).isActive = true
        emailInput.centerYAnchor.constraint(equalTo: curveImage.safeAreaLayoutGuide.centerYAnchor,constant: 20).isActive = true
        emailInput.heightAnchor.constraint(equalToConstant: 50).isActive = true
        emailInput.trailingAnchor.constraint(equalTo:curveImage.trailingAnchor, constant: -14).isActive = true
        emailInput.leadingAnchor.constraint(equalTo:curveImage.leadingAnchor, constant: 14).isActive = true
        
        
        
        resetPasswordBtn.centerXAnchor.constraint(equalTo: curveImage.centerXAnchor).isActive = true
        resetPasswordBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        resetPasswordBtn.widthAnchor.constraint(equalToConstant: 140).isActive = true
        resetPasswordBtn.topAnchor.constraint(equalTo: curveImage.bottomAnchor, constant: -25).isActive = true
        
        errorLabel.centerXAnchor.constraint(equalTo: emailInput.centerXAnchor, constant: -20).isActive = true
        errorLabel.bottomAnchor.constraint(equalTo: emailInput.topAnchor, constant: -15).isActive = true
        errorLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 305).isActive = true
    }

    func configure(){
        view.backgroundColor = UIColor(named: SZ.Colors.appColor)
        

        
        Edits.underlineLabel(loginLabel: resetPasswordLabel)

        
        resetPasswordBtn.setTitle("Reset", for: .normal)
        
        Edits.setupLeftViewMode(input: emailInput, image: UIImage(systemName: "envelope.fill", withConfiguration: Edits.symbol())!)
        
        
        resetPasswordBtn.addTarget(self, action: #selector(resetBtnPr), for: .touchUpInside)
        backBtn.addTarget(self, action: #selector(backBtnPr), for: .touchUpInside)

        
        backBtn.setImage(Edits.returnSymbol(), for: .normal)
        backBtn.tintColor = .white

        Edits.removeAuCorrect(textFields: [emailInput])

        

    }
    
    @objc func resetBtnPr(){
       let inputs = [emailInput]
        let userEmail = emailInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        if Authentications.isInputNotEmpty(inputs: inputs){
            let auth = Auth.auth()
            
            auth.sendPasswordReset(withEmail: userEmail){(error) in
                if error != nil{
                    Authentications.showError(errorLabel: self.errorLabel, message: error!.localizedDescription)
                }
                else{
                    Authentications.showError(errorLabel: self.errorLabel, message: "Password reset email sent")
                    self.errorLabel.textColor = UIColor(named: SZ.Colors.appColor)

                }
            }
        }
        
    
    }
    @objc func backBtnPr(){
        let loginVC = SZLoginVC()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: true, completion: nil)
        
    }
    
}
