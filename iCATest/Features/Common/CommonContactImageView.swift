//
//  CommonContactImageView.swift
//  iCATest
//
//  Created by Ayus Salleh on 15/03/2023.
//

import UIKit

class CommonContactImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = themeColor
        setRoundedCorner()
    }
    
}
 
