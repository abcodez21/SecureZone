//
//  SZFrontCreditCardTVC.swift
//  SecureZone
//
//  Created by Abdallahi Thiaw on 10/27/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SZCreditCardTVC: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var creditCardLabel: UILabel!
    
    
    @IBOutlet weak var copyBtn: UIButton!
    @IBOutlet weak var creditCardNumLabel: UILabel!
    
    @IBOutlet weak var creditCardExpLabel: UILabel!
    @IBOutlet weak var turnBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var creditCardNameLabel: UILabel!
    
    let topView = UIView()
    let bottomView = UIView()
    let cvvLabel = UILabel()
    var delegate: InfoCreditCard?

    var titleName = ""

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configure()
        constraints()
        
        contentView.backgroundColor = .white

        // Configure the view for the selected state
    }
    
    func configure(){
        backView.layer.cornerRadius = 24
        turnBtn.layer.cornerRadius = 65 / 2
        
        turnBtn.layer.borderColor = UIColor(named: SZ.Colors.appColor)?.cgColor
        turnBtn.tintColor = UIColor(named: SZ.Colors.appColor)
        turnBtn.layer.borderWidth = 3
        
        topView.backgroundColor = UIColor(named: SZ.Colors.gray)
        bottomView.backgroundColor = UIColor(named: SZ.Colors.gray)
        cvvLabel.backgroundColor = .white
        cvvLabel.text = " 343 "
        cvvLabel.textColor = UIColor(named: SZ.Colors.appColor)
        


        
        ishidden(ishidden: true)
        
        turnBtn.addTarget(self, action: #selector(turnPr), for: .touchUpInside)


    }
    
    func constraints(){
        backView.addSubview(topView)
        backView.addSubview(bottomView)
        backView.addSubview(cvvLabel)
        
        topView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        cvvLabel.translatesAutoresizingMaskIntoConstraints = false
        
        topView.heightAnchor.constraint(equalToConstant: 42).isActive = true
        topView.leadingAnchor.constraint(equalTo: backView.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        topView.trailingAnchor.constraint(equalTo: backView.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        topView.bottomAnchor.constraint(equalTo: turnBtn.topAnchor, constant: 0).isActive = true
        
        
        bottomView.heightAnchor.constraint(equalToConstant: 39).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: backView.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: cvvLabel.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 40).isActive = true
        
        
        cvvLabel.heightAnchor.constraint(equalToConstant: 39).isActive = true
        cvvLabel.trailingAnchor.constraint(equalTo: turnBtn.safeAreaLayoutGuide.leadingAnchor, constant: -20).isActive = true
        cvvLabel.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 40).isActive = true
        


        
    }
    
    func ishidden(ishidden: Bool){
        var isNothidden = true
        if ishidden{
            isNothidden = false
        }
        
        for t in [deleteBtn, creditCardLabel,
                  copyBtn, creditCardLabel,
                  creditCardExpLabel, creditCardNameLabel,
                  creditCardNumLabel]{
            t?.isHidden = isNothidden
        }
        
        for t in [topView,bottomView,cvvLabel]{
            t.isHidden = ishidden
        }
    }
    
    
    @objc func turnPr(){
        if deleteBtn.isHidden == true{
            ishidden(ishidden: true)
        }else{
            ishidden(ishidden: false)
        }
        
    }
    
    @IBAction func deleteBtnPr(_ sender: UIButton) {
        if let userAccount = Auth.auth().currentUser?.email{
            Authentications.db.collection(userAccount).document(SZ.FirebaseType.creditCard).updateData([titleName:FieldValue.delete()])
            delegate?.fetchData()
        }
    }
    
    @IBAction func copyPr(_ sender: UIButton) {

        
        Edits.copyLabel(text: creditCardNumLabel, copyBtn: copyBtn, size: 24)

    }
    
    
}
