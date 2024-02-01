//
//  SZSettings.swift
//  SecureZone
//
//  Created by Abdallahi Thiaw on 10/16/23.
//

import UIKit

class SZSettings: UIViewController {
    let welcomeLabel = Edits.lableEdit(
        labelColor: UIColor(named: SZ.Colors.appColor)!,
        labelText: "Welcome Back",
        fontName: SZ.Fonts.sf_Regular, fontSize: 25)
    let resetPasswordBtn = Edits.EditButton(
                                            btnText: "Reset Password",
                                            font: UIFont(name: SZ.Fonts.sf_light,size: 22)!,
                                            color: UIColor(named: SZ.Colors.appColor)!)
    
    let passwordSymbol = UIImageView(image: Edits.returnSymbol(symbolName: "eye.slash", size: 20, weightSize: .light))
    
    let logoutBtn = Edits.EditButton(
                                    btnText: "Log Out",
                                    font: UIFont(name: SZ.Fonts.sf_light,size: 22)!,
                                    color: UIColor(named: SZ.Colors.appColor)!)
    
    
    let logoutSymbol = UIImageView(image: Edits.returnSymbol(symbolName: "arrow.turn.down.right", size: 20, weightSize: .light))
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configure()
        constraints()
    }
    
    func configure(){
        self.navigationItem.title = "Settings"
        
        
        logoutBtn.addTarget(self, action: #selector(logOutBtnPr), for: .touchUpInside)
        resetPasswordBtn.addTarget(self, action: #selector(resetPasswordBtnPr), for: .touchUpInside)
        
        

        
    }
    
    func constraints(){
        view.addSubview(welcomeLabel)
        view.addSubview(resetPasswordBtn)
        view.addSubview(passwordSymbol)
        view.addSubview(logoutSymbol)
        view.addSubview(logoutBtn)
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        resetPasswordBtn.translatesAutoresizingMaskIntoConstraints = false
        passwordSymbol.translatesAutoresizingMaskIntoConstraints = false
        logoutBtn.translatesAutoresizingMaskIntoConstraints = false
        logoutSymbol.translatesAutoresizingMaskIntoConstraints = false
        
        welcomeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        resetPasswordBtn.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 40).isActive = true
        resetPasswordBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        
        passwordSymbol.centerYAnchor.constraint(equalTo: resetPasswordBtn.centerYAnchor).isActive = true
        passwordSymbol.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        logoutBtn.topAnchor.constraint(equalTo: resetPasswordBtn.bottomAnchor, constant: 15).isActive = true
        logoutBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        logoutSymbol.centerYAnchor.constraint(equalTo: logoutBtn.centerYAnchor).isActive = true
        logoutSymbol.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    
    @objc func resetPasswordBtnPr(){
        let rpVC = SZResetPasswordVC()
        rpVC.modalPresentationStyle = .fullScreen
        present(rpVC, animated: true, completion: nil)
        
    }
    
    @objc func logOutBtnPr(){
        let loginVc = SZLoginVC()
        loginVc.modalPresentationStyle = .fullScreen
        present(loginVc, animated: true, completion: nil)
        
    }
}
