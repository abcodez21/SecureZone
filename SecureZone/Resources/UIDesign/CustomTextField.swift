import Foundation
import UIKit
class CustomTextField: UITextField {
    let padding: CGFloat = 55
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeLabel()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeLabel()
    }

    func initializeLabel() {
        self.font = UIFont(name: SZ.Fonts.sf_light, size: 18)
        self.backgroundColor = .white
        self.textColor = UIColor(named: SZ.Colors.appColor)
      
        self.layer.cornerRadius = 50 / 2
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor(named: SZ.Colors.appColor)?.cgColor
      
    }
    
    func setupLeftViewMode(image: UIImage) {
        self.leftViewMode = .always
        let leftView = UIImageView(frame: CGRect(x: 0, y: self.frame.height / 2 - 2, width: 35, height: 30))
        leftView.tintColor = .black
        leftView.image = image
        self.addSubview(leftView)
    }
    
    // fix layout
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let bounds = CGRect(x: self.padding, y: 0, width: bounds.width, height: bounds.height)
        return bounds
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let bounds = CGRect(x: self.padding, y: 0, width: bounds.width, height: bounds.height)
        return bounds
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let bounds = CGRect(x: self.padding, y: 0, width: bounds.width, height: bounds.height)
        return bounds
    }
}
