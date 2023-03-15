//
//  BaseViewController.swift
//  iCATest
//
//  Created by Ayus Salleh on 15/03/2023.
//

import UIKit
import NSObject_Rx
import SwifterSwift

class BaseViewController: UIViewController {
    
    func showAlert(_ message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

