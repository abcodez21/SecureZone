import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

final class SZSignupVC: UIViewController {

    let errorLabel = Authentications.errorLabel()

    let appName = Edits.lableEdit(labelColor: .white, labelText: "Secure Zone", fontName: SZ.Fonts.sf_Regular, fontSize: 37)
    
    let signUpLabel = Edits.lableEdit(labelColor: .white, labelText: "Sign Up", fontName: SZ.Fonts.sf_light, fontSize: 33)
    
    let curveImage = Edits.addImg(imgName: SZ.Img.curlyImg)
    let emailInput = Edits.textField(placeHolderText: "Email Address", color: UIColor(named: SZ.Colors.appColor)!)
    let passwordInput = Edits.textField(placeHolderText: "New Password", color: UIColor(named: SZ.Colors.appColor)!)
    let confirmPasswordInput = Edits.textField(placeHolderText: "Confirm Password", color: UIColor(named: SZ.Colors.appColor)!)
    let signUpBtn = CustomButton()
    
    let alreadyAccount = Edits.lableEdit(labelColor: .black, labelText: "Already have an account?", fontName: SZ.Fonts.sf_light, fontSize: 16)
    let logInBtn = Edits.EditButton(
        btnText: "Log In",
        font: UIFont(name: SZ.Fonts.sf_semibold, size: 16)!,
        color: .white)


    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        constrains()

        
    }

    func constrains(){
        self.view.addSubview(appName)
        self.view.addSubview(curveImage)
        self.view.addSubview(signUpLabel)
        self.view.addSubview(alreadyAccount)
        self.view.addSubview(logInBtn)
        
        self.view.addSubview(emailInput)
        self.view.addSubview(passwordInput)
        self.view.addSubview(signUpBtn)
        self.view.addSubview(confirmPasswordInput)
        self.view.addSubview(errorLabel)

        
        appName.translatesAutoresizingMaskIntoConstraints = false
        curveImage.translatesAutoresizingMaskIntoConstraints = false
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        alreadyAccount.translatesAutoresizingMaskIntoConstraints = false
        logInBtn.translatesAutoresizingMaskIntoConstraints = false
        emailInput.translatesAutoresizingMaskIntoConstraints = false
        passwordInput.translatesAutoresizingMaskIntoConstraints = false
        signUpBtn.translatesAutoresizingMaskIntoConstraints = false
        confirmPasswordInput.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false

        
        
        appName.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        appName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 19).isActive = true

        
        curveImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        curveImage.topAnchor.constraint(equalTo: appName.bottomAnchor, constant: 90).isActive = true
        curveImage.heightAnchor.constraint(equalToConstant:400).isActive = true
        curveImage.widthAnchor.constraint(equalToConstant: 365).isActive = true

        signUpLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -33).isActive = true
        signUpLabel.bottomAnchor.constraint(equalTo: curveImage.topAnchor, constant: 35).isActive = true
        
        
        alreadyAccount.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -40).isActive = true
        alreadyAccount.topAnchor.constraint(equalTo: signUpBtn.bottomAnchor, constant: 30).isActive = true
        
        logInBtn.centerYAnchor.constraint(equalTo: alreadyAccount.safeAreaLayoutGuide.centerYAnchor).isActive = true
        logInBtn.leadingAnchor.constraint(equalTo: alreadyAccount.trailingAnchor, constant: 12).isActive = true
        
        emailInput.centerYAnchor.constraint(equalTo: curveImage.safeAreaLayoutGuide.centerYAnchor,constant: -35).isActive = true
        emailInput.heightAnchor.constraint(equalToConstant: 50).isActive = true
        emailInput.trailingAnchor.constraint(equalTo:curveImage.trailingAnchor, constant: -14).isActive = true
        emailInput.leadingAnchor.constraint(equalTo:curveImage.leadingAnchor, constant: 14).isActive = true
        
        passwordInput.heightAnchor.constraint(equalToConstant: 50).isActive = true
        passwordInput.trailingAnchor.constraint(equalTo:curveImage.trailingAnchor, constant: -14).isActive = true
        passwordInput.leadingAnchor.constraint(equalTo:curveImage.leadingAnchor, constant: 14).isActive = true
        passwordInput.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 30).isActive = true
        
        confirmPasswordInput.heightAnchor.constraint(equalToConstant: 50).isActive = true
        confirmPasswordInput.trailingAnchor.constraint(equalTo:curveImage.trailingAnchor, constant: -14).isActive = true
        confirmPasswordInput.leadingAnchor.constraint(equalTo:curveImage.leadingAnchor, constant: 14).isActive = true
        confirmPasswordInput.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 30).isActive = true
        
        signUpBtn.centerXAnchor.constraint(equalTo: curveImage.centerXAnchor).isActive = true
        signUpBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        signUpBtn.widthAnchor.constraint(equalToConstant: 140).isActive = true
        signUpBtn.topAnchor.constraint(equalTo: curveImage.bottomAnchor, constant: -25).isActive = true
        
        errorLabel.centerXAnchor.constraint(equalTo: emailInput.centerXAnchor, constant: -20).isActive = true
        errorLabel.bottomAnchor.constraint(equalTo: emailInput.topAnchor, constant: -15).isActive = true
        errorLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 305).isActive = true

    }

    func configure(){
        view.backgroundColor = UIColor(named: SZ.Colors.appColor)
        
     
        Edits.underlineLabel(loginLabel: signUpLabel)

        signUpBtn.setTitle("Sign Up", for: .normal)
        
        Edits.setupLeftViewMode(input: emailInput, image: UIImage(systemName: "envelope.fill", withConfiguration: Edits.symbol())!)
        Edits.setupLeftViewMode(input: passwordInput, image: UIImage(systemName: "eye.slash", withConfiguration: Edits.symbol())!)
        Edits.setupLeftViewMode(input: confirmPasswordInput, image: UIImage(systemName: "eye.slash", withConfiguration: Edits.symbol())!)
        
        logInBtn.addTarget(self, action: #selector(logInBtnPr), for: .touchUpInside)
        signUpBtn.addTarget(self, action: #selector(signUpBtnPr), for: .touchUpInside)

        Edits.removeAuCorrect(textFields: [confirmPasswordInput, passwordInput, emailInput])


    }
    
    @objc func logInBtnPr(){
        let logInBtn = SZLoginVC()
        logInBtn.modalPresentationStyle = .fullScreen
        present(logInBtn, animated: true, completion: nil)
        
    }
    
    @objc func signUpBtnPr(){
        let userPassword = passwordInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let inputs = [emailInput, passwordInput, confirmPasswordInput]
        
        if Authentications.isInputNotEmpty(inputs: inputs)
            && Authentications.isPasswordMatch(textOne: passwordInput, textTwo: confirmPasswordInput, errorLabel: errorLabel)
            && Authentications.isPasswordValid(password: userPassword, errorLabel: errorLabel){
            let userEmail = emailInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: userEmail, password: userPassword) {(result, error) in
                
                if error != nil{
                    Authentications.showError(errorLabel: self.errorLabel, message: error!.localizedDescription)
                }
                else{
                    
                    let tabVC = SZTabVC()
                    tabVC.modalPresentationStyle = .fullScreen
                    self.present(tabVC, animated: true, completion: nil)
                    
                }
                
            }
            
            
        }
    }
}
