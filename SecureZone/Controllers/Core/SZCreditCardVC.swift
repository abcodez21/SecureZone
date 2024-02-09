import UIKit
import FirebaseAuth


protocol InfoCreditCard {
    func fetchData()
}

class SZCreditCardVC: UIViewController, InfoCreditCard {
    let addBtn = Edits.addBtn()
    
    let inputCreditCardView = UIView()
    let inputCreditCardLabel = Edits.lableEdit(labelColor: .white, labelText: "Enter Credit Card Info", fontName: SZ.Fonts.sf_Regular, fontSize: 23)
    
    let xBtn = UIButton()
    let enterBtn = UIButton()
    let inputCreditCardName = CustomInputTextField(placeHolderText: "Enter Name on Credit Card")
    let inputCreditCardType = CustomInputTextField(placeHolderText: "Enter Type of Credit Card (PNC)")
    let inputCreditCardNum = CustomCreditCardtextField(placeHolderText: "Enter Credit Card Number")
    
    let inputCreditCardExpDate = CustomExpTextField(placeHolderText: "Enter Expiration Date")
    let inputCreditCardCvv = CustomCvvTextField(placeHolderText: "Enter CVV Number")

    let dataView = UITableView()
    
    var inputs = [CustomInputTextField]()
    var creditCardCred: [CreditCard] = []
    var titleNames: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        constraints()
        fetchData()

        // Do any additional setup after loading the view.
    }
    

    func configure(){
        
//        inputCreditCardExpDate.delegate = self
      
        self.navigationItem.title = "Manage Credit Cards"
        dataView.dataSource = self
        inputs = [inputCreditCardType, inputCreditCardName, inputCreditCardNum, inputCreditCardCvv, inputCreditCardExpDate]
        
        inputCreditCardView.backgroundColor = UIColor(named: SZ.Colors.appColor)
        inputCreditCardView.layer.cornerRadius = 50
        inputCreditCardView.isHidden = true
        
        xBtn.setImage(Edits.returnSymbol(symbolName: "xmark.circle", size: 25, weightSize: .medium), for: .normal)
        xBtn.tintColor = .white
        
        enterBtn.setImage(Edits.returnSymbol(symbolName: "arrowshape.turn.up.right", size: 25, weightSize: .medium), for: .normal)
        enterBtn.tintColor = .white
        
        
        xBtn.addTarget(self, action: #selector(xBtnPr), for: .touchUpInside)
        enterBtn.addTarget(self, action: #selector(enterBtnPr), for: .touchUpInside)
        addBtn.addTarget(self, action: #selector(addBtnPr), for: .touchUpInside)
        dataView.register(UINib(nibName: SZ.nibName.creditCard, bundle: nil), forCellReuseIdentifier: SZ.identifier.creditCard)
        dataView.backgroundColor = .white
        
        
        for input in [inputCreditCardCvv, inputCreditCardNum, inputCreditCardExpDate]{
            input.keyboardType = UIKeyboardType.numberPad
        }
    }
    
    func constraints(){
        view.addSubview(addBtn)
        view.addSubview(dataView)
        view.addSubview(inputCreditCardView)
       
        
        inputCreditCardView.addSubview(inputCreditCardLabel)
        inputCreditCardView.addSubview(xBtn)
        inputCreditCardView.addSubview(enterBtn)
        inputCreditCardView.addSubview(inputCreditCardName)
        inputCreditCardView.addSubview(inputCreditCardType)
        inputCreditCardView.addSubview(inputCreditCardNum)
        inputCreditCardView.addSubview(inputCreditCardExpDate)
        inputCreditCardView.addSubview(inputCreditCardCvv)

        
        addBtn.translatesAutoresizingMaskIntoConstraints = false
        inputCreditCardView.translatesAutoresizingMaskIntoConstraints = false
        inputCreditCardLabel.translatesAutoresizingMaskIntoConstraints = false
        xBtn.translatesAutoresizingMaskIntoConstraints = false
        enterBtn.translatesAutoresizingMaskIntoConstraints = false
        inputCreditCardName.translatesAutoresizingMaskIntoConstraints = false
        inputCreditCardType.translatesAutoresizingMaskIntoConstraints = false
        inputCreditCardNum.translatesAutoresizingMaskIntoConstraints = false
        inputCreditCardExpDate.translatesAutoresizingMaskIntoConstraints = false
        inputCreditCardCvv.translatesAutoresizingMaskIntoConstraints = false
        dataView.translatesAutoresizingMaskIntoConstraints = false
        
        
        addBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        addBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        inputCreditCardView.heightAnchor.constraint(equalToConstant: 360).isActive = true
        inputCreditCardView.widthAnchor.constraint(equalToConstant: 370).isActive = true
        inputCreditCardView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputCreditCardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        
        inputCreditCardLabel.centerXAnchor.constraint(equalTo: inputCreditCardView.centerXAnchor).isActive = true
        inputCreditCardLabel.topAnchor.constraint(equalTo: inputCreditCardView.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        
        xBtn.leadingAnchor.constraint(equalTo: inputCreditCardView.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        xBtn.centerYAnchor.constraint(equalTo: inputCreditCardLabel.centerYAnchor).isActive = true
        
        enterBtn.trailingAnchor.constraint(equalTo: inputCreditCardView.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        enterBtn.centerYAnchor.constraint(equalTo: inputCreditCardLabel.centerYAnchor).isActive = true

        inputCreditCardName.trailingAnchor.constraint(equalTo: inputCreditCardView.trailingAnchor, constant: -30).isActive = true
        inputCreditCardName.leadingAnchor.constraint(equalTo: inputCreditCardView.leadingAnchor, constant: 30).isActive = true
        inputCreditCardName.topAnchor.constraint(equalTo: inputCreditCardLabel.bottomAnchor, constant: 50).isActive = true
        inputCreditCardName.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        inputCreditCardType.trailingAnchor.constraint(equalTo: inputCreditCardView.trailingAnchor, constant: -30).isActive = true
        inputCreditCardType.leadingAnchor.constraint(equalTo: inputCreditCardView.leadingAnchor, constant: 30).isActive = true
        inputCreditCardType.topAnchor.constraint(equalTo: inputCreditCardName.bottomAnchor, constant: 10).isActive = true
        inputCreditCardType.heightAnchor.constraint(equalToConstant: 40).isActive = true

        
        inputCreditCardNum.trailingAnchor.constraint(equalTo: inputCreditCardView.trailingAnchor, constant: -30).isActive = true
        inputCreditCardNum.leadingAnchor.constraint(equalTo: inputCreditCardView.leadingAnchor, constant: 30).isActive = true
        inputCreditCardNum.topAnchor.constraint(equalTo: inputCreditCardType.bottomAnchor, constant: 10).isActive = true
        inputCreditCardNum.heightAnchor.constraint(equalToConstant: 40).isActive = true


        inputCreditCardExpDate.trailingAnchor.constraint(equalTo: inputCreditCardView.trailingAnchor, constant: -30).isActive = true
        inputCreditCardExpDate.leadingAnchor.constraint(equalTo: inputCreditCardView.leadingAnchor, constant: 30).isActive = true
        inputCreditCardExpDate.topAnchor.constraint(equalTo: inputCreditCardNum.bottomAnchor, constant: 10).isActive = true
        inputCreditCardExpDate.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        inputCreditCardCvv.trailingAnchor.constraint(equalTo: inputCreditCardView.trailingAnchor, constant: -30).isActive = true
        inputCreditCardCvv.leadingAnchor.constraint(equalTo: inputCreditCardView.leadingAnchor, constant: 30).isActive = true
        inputCreditCardCvv.topAnchor.constraint(equalTo: inputCreditCardExpDate.bottomAnchor, constant: 10).isActive = true
        inputCreditCardCvv.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        dataView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        dataView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        dataView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        dataView.bottomAnchor.constraint(equalTo: addBtn.topAnchor, constant: 0).isActive = true
        
        
        Edits.removeAuCorrect(textFields: inputs)
    }
    
    @objc func xBtnPr(){
        inputCreditCardView.isHidden = true
        dataView.isHidden = false

        Edits.clearInputs(textFieldInputs: inputs)


        
    }
   
    @objc func addBtnPr(){
        inputCreditCardView.isHidden = false
        dataView.isHidden = true
        

        
    }
    
    @objc func enterBtnPr(){
        if Authentications.validateCreds(creditCard: inputCreditCardNum, cvv: inputCreditCardCvv, exp: inputCreditCardExpDate) && Authentications.inputDataVerified(inputs: inputs, dataType: SZ.FirebaseType.creditCard, data1: inputCreditCardType, data2: inputCreditCardName, data3: inputCreditCardNum,data4: inputCreditCardExpDate.text!, data5: inputCreditCardCvv.text! , inputView: inputCreditCardView, dataView: dataView){
            
            
                fetchData()
            
            
        }    }
    
    func fetchData(){
        self.creditCardCred = []
        self.titleNames = []
        if let userAccount = Auth.auth().currentUser?.email{
            Authentications.db.collection(userAccount).document(SZ.FirebaseType.creditCard).getDocument { doc, error in
                if error == nil{
                    let data = doc?.data()
                    self.titleNames.append(contentsOf: data!.keys)
                    for d in data!{
                        let key = data![d.key] as! [String: Any]
                        self.creditCardCred.append(CreditCard(cardType: key["CardType"] as! String, cardName: key["CardName"] as! String, cardNum: key["CardNum"] as! String, cardExp: key["CardExp"] as! String, cardCvv: key["CardCvv"] as! String))
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

extension SZCreditCardVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return creditCardCred.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SZ.identifier.creditCard, for: indexPath) as! SZCreditCardTVC
        cell.creditCardNumLabel.text = "\(creditCardCred[indexPath.row].cardNum)"
        cell.creditCardExpLabel.text = "\(creditCardCred[indexPath.row].cardExp)"
        cell.creditCardNameLabel.text = "\(creditCardCred[indexPath.row].cardName)"
        cell.cvvLabel.text = "\(creditCardCred[indexPath.row].cardCvv)"
        cell.creditCardLabel.text = "\(creditCardCred[indexPath.row].cardType)"
        
        cell.titleName = self.titleNames[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    
}
