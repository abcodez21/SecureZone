import UIKit
import FirebaseAuth

class SZLoginVC: UIViewController {
    let errorLabel = Authentications.errorLabel()
    
    let appName = Edits.lableEdit(labelColor: .white, labelText: "Secure Zone", fontName: SZ.Fonts.sf_Regular, fontSize: 38)
    
    let loginLabel = Edits.lableEdit(labelColor: .white, labelText: "Login", fontName: SZ.Fonts.sf_light, fontSize: 33)
    
    let curveImage = Edits.addImg(imgName: SZ.Img.curlyImg)
    let emailInput = Edits.textField(placeHolderText: "Email Address", color: UIColor(named: SZ.Colors.appColor)!)
    let passwordInput = Edits.textField(placeHolderText: "Password", color: UIColor(named: SZ.Colors.appColor)!)
    
    let forgotPasswordBtn = Edits.EditButton(
                                            btnText: "Forgot Password?",
                                            font: UIFont(name: SZ.Fonts.sf_light, size: 16)!,
                                            color: UIColor(named: SZ.Colors.appColor)!)
    let loginBtn = CustomButton()
    
    let dontHaveAcountLabel = Edits.lableEdit(labelColor: .black, labelText: "Don't have an account?", fontName: SZ.Fonts.sf_light, fontSize: 16)
    let signUpBtn = Edits.EditButton(
        btnText: "Sign Up",
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
        self.view.addSubview(loginLabel)
        self.view.addSubview(dontHaveAcountLabel)
        self.view.addSubview(signUpBtn)
        
        self.view.addSubview(emailInput)
        self.view.addSubview(passwordInput)
        self.view.addSubview(forgotPasswordBtn)
        self.view.addSubview(loginBtn)
        self.view.addSubview(errorLabel)
        
        appName.translatesAutoresizingMaskIntoConstraints = false
        curveImage.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        dontHaveAcountLabel.translatesAutoresizingMaskIntoConstraints = false
        signUpBtn.translatesAutoresizingMaskIntoConstraints = false
        emailInput.translatesAutoresizingMaskIntoConstraints = false
        passwordInput.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordBtn.translatesAutoresizingMaskIntoConstraints = false
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        appName.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        appName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 19).isActive = true

        curveImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        curveImage.topAnchor.constraint(equalTo: appName.bottomAnchor, constant: 90).isActive = true
        curveImage.heightAnchor.constraint(equalToConstant:400).isActive = true
        curveImage.widthAnchor.constraint(equalToConstant: 365).isActive = true

        loginLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -33).isActive = true
        loginLabel.bottomAnchor.constraint(equalTo: curveImage.topAnchor, constant: 35).isActive = true
        
        
        dontHaveAcountLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -40).isActive = true
        dontHaveAcountLabel.topAnchor.constraint(equalTo: loginBtn.bottomAnchor, constant: 30).isActive = true
        
        signUpBtn.centerYAnchor.constraint(equalTo: dontHaveAcountLabel.safeAreaLayoutGuide.centerYAnchor).isActive = true
        signUpBtn.leadingAnchor.constraint(equalTo: dontHaveAcountLabel.trailingAnchor, constant: 12).isActive = true
        
        errorLabel.centerXAnchor.constraint(equalTo: emailInput.centerXAnchor, constant: -20).isActive = true
        errorLabel.bottomAnchor.constraint(equalTo: emailInput.topAnchor, constant: -15).isActive = true
        errorLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 305).isActive = true


        emailInput.centerYAnchor.constraint(equalTo: curveImage.safeAreaLayoutGuide.centerYAnchor,constant: -20).isActive = true
        emailInput.heightAnchor.constraint(equalToConstant: 53).isActive = true
        emailInput.trailingAnchor.constraint(equalTo:curveImage.trailingAnchor, constant: -14).isActive = true
        emailInput.leadingAnchor.constraint(equalTo:curveImage.leadingAnchor, constant: 14).isActive = true
        
        passwordInput.heightAnchor.constraint(equalToConstant: 53).isActive = true
        passwordInput.trailingAnchor.constraint(equalTo:curveImage.trailingAnchor, constant: -14).isActive = true
        passwordInput.leadingAnchor.constraint(equalTo:curveImage.leadingAnchor, constant: 14).isActive = true
        passwordInput.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 30).isActive = true
        
        forgotPasswordBtn.topAnchor.constraint(equalTo: passwordInput.bottomAnchor, constant: 10).isActive = true
        forgotPasswordBtn.trailingAnchor.constraint(equalTo: curveImage.trailingAnchor, constant: -16).isActive = true
        
        loginBtn.centerXAnchor.constraint(equalTo: curveImage.centerXAnchor).isActive = true
        loginBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginBtn.widthAnchor.constraint(equalToConstant: 140).isActive = true
        loginBtn.topAnchor.constraint(equalTo: curveImage.bottomAnchor, constant: -25).isActive = true
    }

    func configure(){
        view.backgroundColor = UIColor(named: SZ.Colors.appColor)
        
        Edits.removeAuCorrect(textFields: [passwordInput, emailInput])

        
        Edits.underlineLabel(loginLabel: loginLabel)
        
        loginBtn.setTitle("Log In", for: .normal)
        
        Edits.setupLeftViewMode(input: emailInput, image: UIImage(systemName: "envelope.fill", withConfiguration: Edits.symbol())!)
        Edits.setupLeftViewMode(input: passwordInput, image: UIImage(systemName: "eye.slash", withConfiguration: Edits.symbol())!)
        
        signUpBtn.addTarget(self, action: #selector(signUpBtnPr), for: .touchUpInside)
        loginBtn.addTarget(self, action: #selector(logInBtnPr), for: .touchUpInside)

        forgotPasswordBtn.addTarget(self, action: #selector(forgotPasswordBtnPr), for: .touchUpInside)
        
      
    }
    
    @objc func signUpBtnPr(){
        let signUpVC = SZSignupVC()
        signUpVC.modalPresentationStyle = .fullScreen
        present(signUpVC, animated: true, completion: nil)
        
    }
   
    @objc func logInBtnPr(){
        let userEmail = emailInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let userPassword = passwordInput.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let inputs = [emailInput, passwordInput]
        
        if  Authentications.isInputNotEmpty(inputs: inputs){Auth.auth().signIn(withEmail: userEmail, password: userPassword) {
            (result, error) in
            
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
    
    @objc func forgotPasswordBtnPr(){
        let forgotvc = SZForgotPassword()
        forgotvc.modalPresentationStyle = .fullScreen
        present(forgotvc, animated: true, completion: nil)
        
    }
}
