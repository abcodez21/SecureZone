//
//  SZEmailTVC.swift
//  SecureZone
//
//  Created by Abdallahi Thiaw on 10/27/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SZEmailTVC: UITableViewCell {
    
    var delegate: InfoEmail?
    
    var titleName = ""
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var accNameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var copyBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
        constraints()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        backView.layer.cornerRadius = 30
        // Configure the view for the selected state
    }
    
    func configure(){
        
        
    }
    
    func constraints(){
        
        
    }
    
    @IBAction func DeleteBtnPr(_ sender: UIButton) {
                if let userAccount = Auth.auth().currentUser?.email{
                    Authentications.db.collection(userAccount).document(SZ.FirebaseType.email).updateData([titleName:FieldValue.delete()])
                    delegate?.fetchData()
                }
    }
    
    
    @IBAction func copyPr(_ sender: UIButton) {
        Edits.copyLabel(text: passwordLabel, copyBtn: copyBtn, size: 22)

    }
    
}
