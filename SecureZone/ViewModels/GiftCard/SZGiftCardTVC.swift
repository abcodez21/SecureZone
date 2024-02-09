import UIKit
import FirebaseAuth
import FirebaseFirestore

class SZGiftCardTVC: UITableViewCell {
    
    var titleName = ""

    var delegate: InfoCode?

    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var giftCardTypeLabel: UILabel!
    @IBOutlet weak var giftCardNum: UILabel!
    
    @IBOutlet weak var copyBtn: UIButton!
    
    @IBOutlet weak var copyLabel: UILabel!
    @IBOutlet weak var giftCardexpLabel: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        backView.layer.cornerRadius = 24
        
        // Configure the view for the selected state
    }
    
    @IBAction func deleteBtnPr(_ sender: UIButton) {
        
        if let userAccount = Auth.auth().currentUser?.email{
            Authentications.db.collection(userAccount).document(SZ.FirebaseType.code).updateData([titleName:FieldValue.delete()])
            delegate?.fetchData()
        }
    }
    
    
    @IBAction func copyPr(_ sender: UIButton) {
        Edits.copyLabel(text: giftCardNum, copyBtn: copyBtn, size: 23)

    }
}
