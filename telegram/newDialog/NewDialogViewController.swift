//
//  NewDialogViewController.swift
//  telegram
//
//  Created by Zalkar on 23/7/21.
//

import UIKit
import JGProgressHUD
import SnapKit

class NewDialogViewController: UIViewController {
    
    private lazy var viewModel: NewDialogViewModel = {
        return NewDialogViewModel(delegate: self)
    }()
    
    private let spinner = JGProgressHUD(style: .dark)

    private let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "Search for users"
        view.becomeFirstResponder()
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.isHidden = true
        view.delegate = self
        view.dataSource = self
        view.frame = view.bounds
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell2")
        return view
    }()
    
    private let noResultsLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "No results"
        label.textAlignment = .center
        label.textColor = .green
        label.font = .systemFont(ofSize: 21, weight: .medium)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI(){
        searchBar.delegate = self
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(dismissSelf))
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(noResultsLabel)
        noResultsLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
            make.width.equalTo(view.frame.width/2)
            make.height.equalTo(200)
        }
    }
    
    @objc func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }

}

extension NewDialogViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
        cell.textLabel?.text = viewModel.results[indexPath.row]["name"]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //start conversation
        let targetUserData = viewModel.results[indexPath.row]
    }
    
}

extension NewDialogViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.replacingOccurrences(of: " ", with: "").isEmpty else {
            return
        }
        
        searchBar.resignFirstResponder()
        viewModel.results.removeAll()
        spinner.show(in: view)
        self.viewModel.searchUsers(query: text)
    }
    
}

extension NewDialogViewController: NewDialogDelegate {
    
    func loadError() {
        self.noResultsLabel.isHidden = false
        self.tableView.isHidden = true
        self.spinner.dismiss()
    }

    func loadSucces() {
        self.noResultsLabel.isHidden = true
        self.tableView.isHidden = false
        self.spinner.dismiss()
        self.tableView.reloadData()
    }
}

