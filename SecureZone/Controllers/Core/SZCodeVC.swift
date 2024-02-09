import UIKit
import FirebaseAuth

protocol InfoCode {
    func fetchData()
}


final class SZCodeVC: UIViewController, InfoCode {
    let addBtn = Edits.addBtn()
    
    // inputEmail text
    let inputCodeView = UIView()
    let inputCodeLabel = Edits.lableEdit(labelColor: .white, labelText: "Enter Gift Card Info", fontName: SZ.Fonts.sf_Regular, fontSize: 23)
    
    let xBtn = UIButton()
    let enterBtn = UIButton()
    let inputCodeType = CustomInputTextField(placeHolderText: "Enter Type of Gift Card (Amazon)")
    let inputCardNum = CustomInputTextField(placeHolderText: "Enter Gift Card Number")
    
    let inputCardExpDate = CustomCreditCardtextField(placeHolderText: "Enter Expiration Date")
    
    let dataView = UITableView()
    var codeCred: [GiftCard] = []
    var titleNames: [String] = []
    var inputs = [CustomInputTextField]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        constraints()
        fetchData()
        
            }
    

    func configure(){
        self.navigationItem.title = "Manage Codes"
        dataView.dataSource = self
        inputCardExpDate.delegate = self
        inputs = [inputCodeType, inputCardNum, inputCardExpDate]
        inputCodeView.backgroundColor = UIColor(named: SZ.Colors.appColor)
        inputCodeView.layer.cornerRadius = 50
        inputCodeView.isHidden = true
        
        xBtn.setImage(Edits.returnSymbol(symbolName: "xmark.circle", size: 25, weightSize: .medium), for: .normal)
        xBtn.tintColor = .white
        
        enterBtn.setImage(Edits.returnSymbol(symbolName: "arrowshape.turn.up.right", size: 25, weightSize: .medium), for: .normal)
        enterBtn.tintColor = .white
        
        
        xBtn.addTarget(self, action: #selector(xBtnPr), for: .touchUpInside)
        enterBtn.addTarget(self, action: #selector(enterBtnPr), for: .touchUpInside)
        addBtn.addTarget(self, action: #selector(addBtnPr), for: .touchUpInside)
        dataView.register(UINib(nibName: SZ.nibName.code, bundle: nil), forCellReuseIdentifier: SZ.identifier.code)
        
        Edits.removeAuCorrect(textFields: inputs)
        inputCardExpDate.keyboardType = UIKeyboardType.numberPad

        dataView.backgroundColor = .white

    }
    
    func constraints(){
        view.addSubview(addBtn)
        view.addSubview(inputCodeView)
        view.addSubview(dataView)
        
        inputCodeView.addSubview(inputCodeLabel)
        inputCodeView.addSubview(xBtn)
        inputCodeView.addSubview(enterBtn)
        inputCodeView.addSubview(inputCodeType)
        inputCodeView.addSubview(inputCardNum)
        inputCodeView.addSubview(inputCardExpDate)

        
        addBtn.translatesAutoresizingMaskIntoConstraints = false
        inputCodeView.translatesAutoresizingMaskIntoConstraints = false
        inputCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        xBtn.translatesAutoresizingMaskIntoConstraints = false
        enterBtn.translatesAutoresizingMaskIntoConstraints = false
        inputCodeType.translatesAutoresizingMaskIntoConstraints = false
        inputCardNum.translatesAutoresizingMaskIntoConstraints = false
        inputCardExpDate.translatesAutoresizingMaskIntoConstraints = false
        dataView.translatesAutoresizingMaskIntoConstraints = false

        
        
        addBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        addBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        inputCodeView.heightAnchor.constraint(equalToConstant: 310).isActive = true
        inputCodeView.widthAnchor.constraint(equalToConstant: 370).isActive = true
        inputCodeView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputCodeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        
        inputCodeLabel.centerXAnchor.constraint(equalTo: inputCodeView.centerXAnchor).isActive = true
        inputCodeLabel.topAnchor.constraint(equalTo: inputCodeView.safeAreaLayoutGuide.topAnchor, constant: 15).isActive = true
        
        xBtn.leadingAnchor.constraint(equalTo: inputCodeView.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        xBtn.centerYAnchor.constraint(equalTo: inputCodeLabel.centerYAnchor).isActive = true
        
        enterBtn.trailingAnchor.constraint(equalTo: inputCodeView.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        enterBtn.centerYAnchor.constraint(equalTo: inputCodeLabel.centerYAnchor).isActive = true

       
        inputCodeType.trailingAnchor.constraint(equalTo: inputCodeView.trailingAnchor, constant: -30).isActive = true
        inputCodeType.leadingAnchor.constraint(equalTo: inputCodeView.leadingAnchor, constant: 30).isActive = true
        inputCodeType.topAnchor.constraint(equalTo: inputCodeLabel.bottomAnchor, constant: 50).isActive = true
        inputCodeType.heightAnchor.constraint(equalToConstant: 40).isActive = true

        
        inputCardNum.trailingAnchor.constraint(equalTo: inputCodeView.trailingAnchor, constant: -30).isActive = true
        inputCardNum.leadingAnchor.constraint(equalTo: inputCodeView.leadingAnchor, constant: 30).isActive = true
        inputCardNum.topAnchor.constraint(equalTo: inputCodeType.bottomAnchor, constant: 10).isActive = true
        inputCardNum.heightAnchor.constraint(equalToConstant: 40).isActive = true


        inputCardExpDate.trailingAnchor.constraint(equalTo: inputCodeView.trailingAnchor, constant: -30).isActive = true
        inputCardExpDate.leadingAnchor.constraint(equalTo: inputCodeView.leadingAnchor, constant: 30).isActive = true
        inputCardExpDate.topAnchor.constraint(equalTo: inputCardNum.bottomAnchor, constant: 10).isActive = true
        inputCardExpDate.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        dataView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        dataView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        dataView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        dataView.bottomAnchor.constraint(equalTo: addBtn.topAnchor, constant: 0).isActive = true
        
    }
    
    @objc func xBtnPr(){
        inputCodeView.isHidden = true
        dataView.isHidden = false
        Edits.clearInputs(textFieldInputs: inputs)

    }
   
    @objc func addBtnPr(){
        inputCodeView.isHidden = false
        dataView.isHidden = true

        
    }
    
    @objc func enterBtnPr(){
        if Authentications.inputDataVerified(inputs: inputs, dataType: SZ.FirebaseType.code, data1: inputCodeType, data2: inputCardNum, data3: inputCardExpDate, inputView: inputCodeView, dataView: dataView){
            fetchData()
        }

    }
    
    
    func fetchData(){
        self.codeCred = []
        self.titleNames = []
        if let userAccount = Auth.auth().currentUser?.email{
            Authentications.db.collection(userAccount).document(SZ.FirebaseType.code).getDocument { doc, error in
                if error == nil{
                    let data = doc?.data()
                    self.titleNames.append(contentsOf: data!.keys)
                    for d in data!{
                        let key = data![d.key] as! [String: Any]
                        self.codeCred.append(GiftCard(cardType: key["CardType"] as! String, cardNum: key["CardNum"] as! String, cardExp: key["CardExp"] as! String))
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

extension SZCodeVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return codeCred.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SZ.identifier.code, for: indexPath) as! SZGiftCardTVC
        
        cell.giftCardNum.text = "\(codeCred[indexPath.row].cardNum)"
        cell.giftCardTypeLabel.text = "\(codeCred[indexPath.row].cardType)"
        cell.giftCardexpLabel.text =  "\(codeCred[indexPath.row].cardExp)"
        cell.delegate = self

        cell.titleName = self.titleNames[indexPath.row]

        return cell
    }
    
    
}

extension SZCodeVC: UITextFieldDelegate{
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
