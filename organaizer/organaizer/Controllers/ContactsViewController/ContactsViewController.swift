//
//  ContactsViewController.swift
//  organaizer
//
//  Created by Александр Воробей on 21.07.2021.
//

import UIKit
import RealmSwift

class ContactsViewController: UIViewController {
    
    private let searchController = UISearchController()
    
    private let idContactsCell = "idContactsCell"
    
    private let localRealm = try! Realm()
    private var contactsArray: Results<ContactModel>!
    private var filtredArray: Results<ContactModel>!
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        //tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        tableView.separatorStyle = .singleLine
        return tableView
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Friends", "Teachers"])
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return true }
        return text.isEmpty
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contacts"
        
        view.backgroundColor = .white
        
        searchController.searchBar.placeholder = "Search"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        
        contactsArray = localRealm.objects(ContactModel.self).filter("contactsType = 'Friend'")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: idContactsCell)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        
        setConstraints()
        
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
    }
    
    @objc private func segmentChanged() {
        if segmentedControl.selectedSegmentIndex == 0 {
            contactsArray = localRealm.objects(ContactModel.self).filter("contactsType = 'Friend'")
            tableView.reloadData()
        } else {
            contactsArray = localRealm.objects(ContactModel.self).filter("contactsType = 'Teacher'")
            tableView.reloadData()
        }
    }
    
    @objc private func addButtonTapped() {
        let contactsOptionsVC = ContactsOptionsTableViewController()
        navigationController?.pushViewController(contactsOptionsVC, animated: true)
    }
}

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? filtredArray.count : contactsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idContactsCell, for: indexPath) as! ContactsTableViewCell
        let model = isFiltering ? filtredArray[indexPath.row] : contactsArray[indexPath.row]
        cell.configure(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("ZZZ")
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editingRow = contactsArray[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
            RealmManager.shared.deleteContactModel(model: editingRow)
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

extension ContactsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filtredArray = contactsArray.filter("contactsName CONTAINS[c] %@", searchText)
        tableView.reloadData()
    }
    
}

extension ContactsViewController {
    private func setConstraints() {
        let stackView = UIStackView(arrangedSubviews: [segmentedControl, tableView], axis: .vertical, spacing: 0, distribution: .equalSpacing)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
