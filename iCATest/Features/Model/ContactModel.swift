//
//  ContactModel.swift
//  iCATest
//
//  Created by Ayus Salleh on 15/03/2023.
//

import Foundation

class ContactModel: Codable {
    var id: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var email: String?
    var phone: String?
    
    init(id: String, firstName: String, lastName: String, email: String? = nil, phone: String? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phone = phone
    }
}
