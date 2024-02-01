
import UIKit

class Edits {
    // creating imageView
    static func addImg(imgName: String) -> UIImageView{
        let image = UIImage(named: imgName)
        let imageView = UIImageView(image: image!)
        
        return imageView
    }
    
    
    // creating label
    static func lableEdit(labelColor: UIColor,labelText: String, fontName: String, fontSize: CGFloat) -> UILabel{
       
        let label = UILabel()
        label.textColor = labelColor
        label.font = UIFont(name: fontName, size: fontSize)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.text = labelText
        return label
    }
    
    
    
    // custom placeholder for textfield
    static func textField(placeHolderText: String, color: UIColor = UIColor.gray) -> CustomTextField{
        let field = CustomTextField()

        field.attributedPlaceholder = NSAttributedString(
            string: placeHolderText,
            attributes: [NSAttributedString.Key.foregroundColor: color])
        
        return field
    }
    
// aligning icons on textfields
    static func setupLeftViewMode(input: CustomTextField ,image: UIImage) {
        input.leftViewMode = .always
        let leftView = UIImageView()
        leftView.tintColor = UIColor(named: SZ.Colors.appColor)
        leftView.image = image
        leftView.contentMode = .scaleAspectFit
        input.addSubview(leftView)
        leftView.translatesAutoresizingMaskIntoConstraints = false
        leftView.centerYAnchor.constraint(equalTo: input.centerYAnchor).isActive = true
        leftView.leadingAnchor.constraint(equalTo: input.leadingAnchor, constant: 10).isActive = true
        leftView.heightAnchor.constraint(equalToConstant: 26).isActive = true
        leftView.widthAnchor.constraint(equalToConstant: 30).isActive = true


    }
    
    static func symbol() -> UIImage.SymbolConfiguration{
        let modifyWeight = UIImage.SymbolConfiguration(weight: .ultraLight)
        return modifyWeight
    }
    
    // return symbol for resetpassowrdVC
    static func returnSymbol(
                            symbolName: String = "lessthan",
                            size: CGFloat = 30,
                            weightSize: UIImage.SymbolWeight = .medium ) -> UIImage{
        let modifySymbol = UIImage.SymbolConfiguration(pointSize: size, weight: weightSize, scale: .large)
        let image = UIImage(systemName: symbolName, withConfiguration: modifySymbol)?.withTintColor(.white)
        
    
        return image!
    }
    
    static func EditButton(btnText: String, font: UIFont, color: UIColor) -> UIButton{
        let btn = UIButton()
        btn.setTitle(btnText, for: .normal)
        btn.titleLabel?.font = font
        btn.setTitleColor(color, for: .normal)
        return btn
    }
    
    // add button data
    static func addBtn() -> UIButton{
        let addBtn = UIButton()
        addBtn.setImage(returnSymbol(symbolName: "plus.square.fill", size: 38, weightSize: .light), for: .normal)
        addBtn.tintColor = UIColor(named: SZ.Colors.appColor)
        return addBtn
    }
    
    
    // remove auto correct
    static func removeAuCorrect(textFields: [UITextField]){
        for text in textFields{
            text.autocorrectionType = .no
            text.autocapitalizationType = .none
        }
        
    }
    
    // underlining label
    static func underlineLabel(loginLabel: UILabel){
        let attributedString = NSMutableAttributedString.init(string: loginLabel.text!)
                
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: 1, range:
                    NSRange.init(location: 0, length: attributedString.length));
                loginLabel.attributedText = attributedString
    }
    
    // clear inputs
    static func clearInputs(textFieldInputs: [UITextField]){
        for input in textFieldInputs {
            input.text = ""
        }
    }
    
   // copy button pressed
    static func copyLabel(text: UILabel, copyBtn: UIButton, size: CGFloat){
        let clearText = text.text?.replacingOccurrences(of: " ", with: "")
        UIPasteboard.general.string = clearText
        copyBtn.setImage(Edits.returnSymbol(symbolName: "doc.on.doc.fill", size: size), for: .normal)

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { // Change `2.0` to the desired number of seconds.
            copyBtn.setImage(Edits.returnSymbol(symbolName: "doc.on.doc", size: size), for: .normal)

        }
    }
    
    // input error
    static func inputError(input: UITextField, errorText: String){
        input.attributedPlaceholder = NSAttributedString(
            string: errorText,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
    }
    
}
