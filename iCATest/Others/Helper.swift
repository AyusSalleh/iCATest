//
//  Helper.swift
//  iCATest
//
//  Created by Ayus Salleh on 15/03/2023.
//

import UIKit

class Helper: NSObject {

    static let shared = Helper()

    private var jsonFilePath: URL? {
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            return nil
        }
        
        let pathURL = URL(fileURLWithPath: path)
        return pathURL
    }
    
    func getContactData(completion: @escaping (_ contacts: [ContactModel], _ error: String?)->()) {
        guard let filePath = jsonFilePath else {
            completion([], errorMessage)
            return
        }

        do {
            let data = try Data(contentsOf: filePath)
            let contacts = try JSONDecoder().decode([ContactModel].self, from: data)
            completion(contacts, nil)
        } catch {
            completion([], errorMessage)
        }
    }
    
    func updateContactData(contact: ContactModel, completion: @escaping (_ error: String?)->()) {
        guard let filePath = jsonFilePath else {
            completion(errorMessage)
            return
        }
        
        getContactData { [weak self] contacts, error in
            guard let _ = self else { return }
            
            var tempContacts = contacts
            if let index = contacts.enumerated().filter({ $0.element.id == contact.id }).map({ $0.offset }).first {
                tempContacts[index].firstName = contact.firstName
                tempContacts[index].lastName = contact.lastName
                tempContacts[index].email = contact.email
                tempContacts[index].phone = contact.phone
            } else {
                tempContacts.insert(contact, at: 0)
            }
            
            do {
                let encoder = JSONEncoder()
                let jsonData = try encoder.encode(tempContacts)
                try jsonData.write(to: filePath)
                completion(nil)
            } catch {
                completion(errorMessage)
            }
        }
    }
    
}
