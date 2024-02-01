//
//  SZEmailViewController.swift
//  SecureZone
//
//  Created by Abdallahi Thiaw on 10/11/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseDatabase


protocol InfoEmail {
    func fetchData()
}

class SZEmailVC: UIViewController, InfoEmail {
    
    let addBtn = Edits.addBtn()
   
    
    let inputEmailView = UIView()
    let inputEmailLabel = Edits.lableEdit(labelColor: .white, labelText: "Enter Account Info", fontName: SZ.Fonts.sf_Regular, fontSize: 23)
    let xBtn = UIButton()
    let enterBtn = UIButton()
    let inputEmailAccName = CustomInputTextField(placeHolderText: "Enter Account Name")
    let inputEmailemailName = CustomInputTextField(placeHolderText: "Enter Account Email")
    let inputEmailPasswordName = CustomInputTextField(placeHolderText: "Enter Account Password")
    
    let dataView = UITableView()
    
    var inputs = [CustomInputTextField]()
    var emailCred: [Email] = []
    var titleNames: [String] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        constraints()
        fetchData()
    }
    
    func configure(){
        
        dataView.dataSource = self
        inputs = [inputEmailAccName, inputEmailemailName, inputEmailPasswordName]
        self.navigationItem.title = "Manage Emails"
        
        inputEmailView.backgroundColor = UIColor(named: SZ.Colors.appColor)
        inputEmailView.layer.cornerRadius = 50.0
        inputEmailView.isHidden = true
        
        xBtn.setImage(Edits.returnSymbol(symbolName: "xmark.circle", size: 25, weightSize: .medium), for: .normal)
        xBtn.tintColor = .white
        
        enterBtn.setImage(Edits.returnSymbol(symbolName: "arrowshape.turn.up.right", size: 25, weightSize: .medium), for: .normal)
        enterBtn.tintColor = .white
        
        
        xBtn.addTarget(self, action: #selector(xBtnPr), for: .touchUpInside)
        enterBtn.addTarget(self, action: #selector(enterBtnPr), for: .touchUpInside)
        addBtn.addTarget(self, action: #selector(addBtnPr), for: .touchUpInside)
        
        dataView.register(UINib(nibName: SZ.nibName.email, bundle: nil), forCellReuseIdentifier: SZ.identifier.email)
        dataView.backgroundColor = .white
        
        Edits.removeAuCorrect(textFields: inputs)
        inputEmailemailName.keyboardType = UIKeyboardType.emailAddress

        
        
    }
    
    func constraints(){
        view.addSubview(addBtn)
        view.addSubview(inputEmailView)
        view.addSubview(dataView)
        
        inputEmailView.addSubview(inputEmailLabel)
        inputEmailView.addSubview(xBtn)
        inputEmailView.addSubview(enterBtn)
        inputEmailView.addSubview(inputEmailemailName)
        inputEmailView.addSubview(inputEmailAccName)
        inputEmailView.addSubview(inputEmailPasswordName)
        
        
        addBtn.translatesAutoresizingMaskIntoConstraints = false
        inputEmailView.translatesAutoresizingMaskIntoConstraints = false
        inputEmailLabel.translatesAutoresizingMaskIntoConstraints = false
        xBtn.translatesAutoresizingMaskIntoConstraints = false
        enterBtn.translatesAutoresizingMaskIntoConstraints = false
        inputEmailemailName.translatesAutoresizingMaskIntoConstraints = false
        inputEmailAccName.translatesAutoresizingMaskIntoConstraints = false
        inputEmailPasswordName.translatesAutoresizingMaskIntoConstraints = false
        dataView.translatesAutoresizingMaskIntoConstraints = false
        
        
        addBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        addBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        inputEmailView.heightAnchor.constraint(equalToConstant: 270).isActive = true
        inputEmailView.widthAnchor.constraint(equalToConstant: 370).isActive = true
        inputEmailView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputEmailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        
        inputEmailLabel.centerXAnchor.constraint(equalTo: inputEmailView.centerXAnchor).isActive = true
        inputEmailLabel.topAnchor.constraint(equalTo: inputEmailView.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        
        xBtn.leadingAnchor.constraint(equalTo: inputEmailView.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        xBtn.centerYAnchor.constraint(equalTo: inputEmailLabel.centerYAnchor).isActive = true
        
        enterBtn.trailingAnchor.constraint(equalTo: inputEmailView.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        enterBtn.centerYAnchor.constraint(equalTo: inputEmailLabel.centerYAnchor).isActive = true
        
        inputEmailAccName.trailingAnchor.constraint(equalTo: inputEmailView.trailingAnchor, constant: -30).isActive = true
        inputEmailAccName.leadingAnchor.constraint(equalTo: inputEmailView.leadingAnchor, constant: 30).isActive = true
        inputEmailAccName.topAnchor.constraint(equalTo: inputEmailLabel.bottomAnchor, constant: 50).isActive = true
        inputEmailAccName.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        inputEmailemailName.trailingAnchor.constraint(equalTo: inputEmailView.trailingAnchor, constant: -30).isActive = true
        inputEmailemailName.leadingAnchor.constraint(equalTo: inputEmailView.leadingAnchor, constant: 30).isActive = true
        inputEmailemailName.topAnchor.constraint(equalTo: inputEmailAccName.bottomAnchor, constant: 10).isActive = true
        inputEmailemailName.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        inputEmailPasswordName.trailingAnchor.constraint(equalTo: inputEmailView.trailingAnchor, constant: -30).isActive = true
        inputEmailPasswordName.leadingAnchor.constraint(equalTo: inputEmailView.leadingAnchor, constant: 30).isActive = true
        inputEmailPasswordName.topAnchor.constraint(equalTo: inputEmailemailName.bottomAnchor, constant: 10).isActive = true
        inputEmailPasswordName.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        dataView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        dataView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        dataView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        dataView.bottomAnchor.constraint(equalTo: addBtn.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        
        
    }
    
    @objc func xBtnPr(){
        inputEmailView.isHidden = true
        dataView.isHidden = false
        Edits.clearInputs(textFieldInputs: inputs)

    }
    
    @objc func addBtnPr(){
        inputEmailView.isHidden = false
        dataView.isHidden = true
        
        
    }
    
    @objc func enterBtnPr(){
        
        if Authentications.inputDataVerified(inputs: inputs, dataType: SZ.FirebaseType.email, data1: inputEmailAccName, data2: inputEmailemailName, data3: inputEmailPasswordName, inputView: inputEmailView, dataView: dataView){
            fetchData()
        }
        
    }
    
    
    func fetchData(){
        self.emailCred = []
        self.titleNames = []
        if let userAccount = Auth.auth().currentUser?.email{
            Authentications.db.collection(userAccount).document(SZ.FirebaseType.email).getDocument { doc, error in
                if error == nil{
                    let data = doc?.data()
                    self.titleNames.append(contentsOf: data!.keys)
                    for d in data!{
                        let key = data![d.key] as! [String: Any]
                        self.emailCred.append(Email(name: key["AccountType"]! as! String, email: key["Email"]! as! String, password: key["Password"]! as! String))
                    }
                }
                DispatchQueue.main.async {
                    self.dataView.reloadData()
                    Edits.clearInputs(textFieldInputs: self.inputs)

                }
            }
        }
            }
}
    
    extension SZEmailVC: UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return emailCred.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: SZ.identifier.email, for: indexPath) as! SZEmailTVC
            
            cell.accNameLabel.text = "\(emailCred[indexPath.row].name)"
            cell.emailLabel.text = "\(emailCred[indexPath.row].email)"
            cell.passwordLabel.text = "\(emailCred[indexPath.row].password)"
            cell.titleName = self.titleNames[indexPath.row]
            cell.delegate = self
           
            return cell
        }
    }
