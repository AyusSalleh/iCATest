//
//  DetailViewModel.swift
//  iCATest
//
//  Created by Ayus Salleh on 15/03/2023.
//

import Foundation
import RxCocoa
import RxSwift

class DetailViewModel: BaseViewModel {
    
    let contact = BehaviorRelay<ContactModel?>.init(value: nil)
    let firstName = BehaviorRelay<String>.init(value: "")
    let lastName = BehaviorRelay<String>.init(value: "")
    let email = BehaviorRelay<String>.init(value: "")
    let phone = BehaviorRelay<String>.init(value: "")
    
    let successSave = PublishSubject<Void>()
    
    func getData() {
        guard let contact = contact.value else { return }
        
        firstName.accept(contact.firstName)
        lastName.accept(contact.lastName)
        email.accept(contact.email ?? "")
        phone.accept(contact.phone ?? "")
    }
    
    func saveData() {
        if validate() {
            return
        }

        var tempContact: ContactModel
        if let contact = contact.value {
            tempContact = ContactModel(id: contact.id, firstName: firstName.value, lastName: lastName.value, email: email.value, phone: phone.value)
        } else {
            let id = UUID().uuidString
            tempContact = ContactModel(id: id, firstName: firstName.value, lastName: lastName.value, email: email.value, phone: phone.value)
        }

        Helper.shared.updateContactData(contact: tempContact) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                self.showError.onNext(error)
            } else {
                self.successSave.onNext(())
            }
        }
    }

    private func validate() -> Bool {
        if firstName.value.isEmpty {
            let errorMessage = "First Name is Required!"
            self.showError.onNext(errorMessage)
            return true
        } else if lastName.value.isEmpty {
            let errorMessage = "Last Name is Required!"
            self.showError.onNext(errorMessage)
            return true
        }
        
        return false
    }
}
