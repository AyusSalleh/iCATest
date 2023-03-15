//
//  DetailViewController.swift
//  iCATest
//
//  Created by Ayus Salleh on 15/03/2023.
//

import UIKit

protocol DetailViewControllerDelegate: AnyObject {
    func didUpdate()
}

class DetailViewController: BaseViewController {

    @IBOutlet weak var tfFirstName: CommonTextFieldView!
    @IBOutlet weak var tfLastName: CommonTextFieldView!
    @IBOutlet weak var tfEmail: CommonTextFieldView!
    @IBOutlet weak var tfPhone: CommonTextFieldView!

    lazy var viewModel = DetailViewModel()
    
    weak var delegate: DetailViewControllerDelegate?
    
    init(contact: ContactModel? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel.contact.accept(contact)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureRx()
        configureData()
        // Do any additional setup after loading the view.
    }
    
    private func configureUI() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelBarBtnItemTapped))
        self.navigationItem.leftBarButtonItem?.tintColor = themeColor
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveBarBtnItemTapped))
        self.navigationItem.rightBarButtonItem?.tintColor = themeColor
        
        tfFirstName.textField.delegate = self
        tfLastName.textField.delegate = self
        tfPhone.textField.delegate = self
        tfEmail.textField.delegate = self
    }
    
    private func configureRx() {
        _ = tfFirstName.textField.rx.textInput <-> viewModel.firstName
        _ = tfLastName.textField.rx.textInput <-> viewModel.lastName
        _ = tfEmail.textField.rx.textInput <-> viewModel.email
        _ = tfPhone.textField.rx.textInput <-> viewModel.phone

        viewModel.showError.subscribe(onNext: { [weak self] message in
            guard let self = self else { return }
            self.showAlert(message)
        }).disposed(by: rx.disposeBag)
        
        viewModel.successSave.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.delegate?.didUpdate()
            self.navigationController?.popViewController(animated: true)
        }).disposed(by: rx.disposeBag)
    }
    
    private func configureData() {
        viewModel.getData()
    }
    
    @objc func cancelBarBtnItemTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func saveBarBtnItemTapped() {
        viewModel.saveData()
    }
    
}

extension DetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tfFirstName.textField {
            tfLastName.textField.becomeFirstResponder()
        } else if textField == tfLastName.textField {
            tfEmail.textField.becomeFirstResponder()
        } else if textField == tfEmail.textField {
            tfPhone.textField.becomeFirstResponder()
        } else {
            return true
        }
        
        return false
    }
}
