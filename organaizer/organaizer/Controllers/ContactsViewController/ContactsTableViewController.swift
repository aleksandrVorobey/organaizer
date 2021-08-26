//
//  ContactsViewController.swift
//  organaizer
//
//  Created by Александр Воробей on 21.07.2021.
//

import UIKit

class ContactsTableViewController: UITableViewController {
    
    private let searchController = UISearchController()
    
    private let idContactsCell = "idContactsCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: idContactsCell)
        
        tableView.backgroundColor = #colorLiteral(red: 0.9272904481, green: 0.9109478226, blue: 0.9396332249, alpha: 1)
        tableView.separatorStyle = .singleLine

        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        
        
        title = "Contacts"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
    
    @objc private func addButtonTapped() {
        let contactsOptionsVC = ContactsOptionsTableViewController()
        navigationController?.pushViewController(contactsOptionsVC, animated: true)
        print("taptap")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idContactsCell, for: indexPath) as! ContactsTableViewCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       print("ZZZ")
    }
    
}

