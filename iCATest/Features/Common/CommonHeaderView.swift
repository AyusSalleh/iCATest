//
//  CommonHeaderView.swift
//  iCATest
//
//  Created by Ayus Salleh on 15/03/2023.
//

import Foundation
import UIKit

@IBDesignable
class CommonHeaderView: UIView {

    @IBOutlet var view: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
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
        guard let customView = UINib(resource: R.nib.commonHeaderView).instantiate(withOwner: self, options: nil).first as? UIView else { return }
        customView.frame = bounds
        customView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(customView)
        view = customView
        view.backgroundColor = .systemGroupedBackground
        backgroundColor = .clear
    }
    
}
