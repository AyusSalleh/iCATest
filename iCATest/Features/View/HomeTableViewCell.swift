//
//  HomeTableViewCell.swift
//  iCATest
//
//  Created by Ayus Salleh on 15/03/2023.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var lblContactName: UILabel!
    
    var model: ContactModel? {
        didSet {
            guard let model = model else { return }
            lblContactName.text = "\(model.firstName) \(model.lastName)"
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
