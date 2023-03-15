//
//  HomeViewModel.swift
//  iCATest
//
//  Created by Ayus Salleh on 15/03/2023.
//

import Foundation
import RxCocoa
import RxSwift

class HomeViewModel: BaseViewModel {
    
    let allData = BehaviorRelay<[ContactModel]>.init(value: [])
    let data = BehaviorRelay<[ContactModel]>.init(value: [])
    let filterText = BehaviorRelay<String>.init(value: "")

    func getData() {
        Helper.shared.getContactData { [weak self] (contacts, error) in
            guard let self = self else { return }
            
            if let error = error {
                self.showError.onNext(error)
            } else {
                self.allData.accept(contacts)
                self.data.accept(contacts)
            }
        }
    }
    
    func filterData(_ searchText: String?) {
        let searchTextLowercased = (searchText ?? "").lowercased()
        
        let tempData = searchTextLowercased.isEmpty ? allData.value : allData.value.filter{ "\($0.firstName.lowercased()) \($0.lastName.lowercased())".contains(searchTextLowercased) }
        data.accept(tempData)
    }
    
}
