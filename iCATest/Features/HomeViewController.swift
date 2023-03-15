//
//  HomeViewController.swift
//  iCATest
//
//  Created by Ayus Salleh on 15/03/2023.
//

import UIKit
import RxCocoa
import RxSwift

class HomeViewController: BaseViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel = HomeViewModel()
    
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureUI()
        configureRx()
        configureData()
    }

    private func configureTableView() {
        tableView.refreshControl = refreshControl
        tableView.backgroundColor = .clear
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.register(nibWithCellClass: HomeTableViewCell.self)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 80
    }
    
    private func configureUI() {
        title = "Contacts"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchBarBtnItemTapped))
        self.navigationItem.leftBarButtonItem?.tintColor = themeColor
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarBtnItemTapped))
        self.navigationItem.rightBarButtonItem?.tintColor = themeColor
        
        searchBar.isHidden = true
    }
    
    private func configureRx() {
        refreshControl.rx.controlEvent(.valueChanged).subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.viewModel.getData()
            self.refreshControl.endRefreshing()
        }).disposed(by: rx.disposeBag)
        
        searchBar.rx.text
            .throttle(RxTimeInterval.seconds(Int(0.3)), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] searchText in
                guard let `self` = self else { return }
                self.viewModel.filterData(searchText)
        }).disposed(by: rx.disposeBag)
        
        searchBar.rx.cancelButtonClicked
           .asDriver(onErrorJustReturn: ())
           .drive(onNext: { [weak self] in
               guard let self = self else { return }
               self.searchBar.resignFirstResponder()
               self.searchBar.isHidden = true
               self.searchBar.text = ""
               self.viewModel.getData()
           })
           .disposed(by: rx.disposeBag)
        
        viewModel.data.bind(to: tableView.rx.items(cellIdentifier: HomeTableViewCell.identifier, cellType: HomeTableViewCell.self)) { [weak self] (index, model, cell) in
            guard let _ = self else { return }
            cell.model = model
        }.disposed(by: rx.disposeBag)
        
        tableView.rx.modelSelected(ContactModel.self).subscribe(onNext: { [weak self] contact in
            guard let `self` = self else { return }
            let vc = DetailViewController(contact: contact)
            vc.delegate = self
            self.navigationController?.pushViewController(vc)
        }).disposed(by: rx.disposeBag)
        
        viewModel.showError.subscribe(onNext: { [weak self] message in
            guard let self = self else { return }
            self.showAlert(message)
        }).disposed(by: rx.disposeBag)
    }
    
    private func configureData() {
        viewModel.getData()
    }
    
    @objc func searchBarBtnItemTapped() {
        searchBar.isHidden = !searchBar.isHidden
        
        if !searchBar.isHidden {
            searchBar.becomeFirstResponder()
        } else {
            searchBar.resignFirstResponder()
        }
    }
    
    @objc func addBarBtnItemTapped() {
        let vc = DetailViewController()
        vc.delegate = self
        self.navigationController?.pushViewController(vc)
    }

}

extension HomeViewController: DetailViewControllerDelegate {
    func didUpdate() {
        configureData()
    }
}
