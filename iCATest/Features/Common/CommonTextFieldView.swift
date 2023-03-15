//
//  CommonTextFieldView.swift
//  iCATest
//
//  Created by Ayus Salleh on 15/03/2023.
//

import UIKit

@IBDesignable
class CommonTextFieldView: UIView {

    @IBOutlet var view: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    @IBInspectable var title: String? {
        didSet {
            lblTitle.text = title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        commonInit()
    }
    
    func commonInit() {
        guard let customView = UINib(resource: R.nib.commonTextFieldView).instantiate(withOwner: self, options: nil).first as? UIView else { return }
        customView.frame = bounds
        customView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(customView)
        view = customView
        view.backgroundColor = .clear
        backgroundColor = .clear
    }
    
}
