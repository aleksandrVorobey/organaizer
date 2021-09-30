//
//  TeachersViewController.swift
//  organaizer
//
//  Created by Александр Воробей on 27.07.2021.
//

import UIKit
import RealmSwift

class TeachersTableViewController: UITableViewController {
    
    private let localRealm = try! Realm()
    private var contactsArray: Results<ContactModel>!
    private let teacherId = "teacherId"

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Teachers"
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: teacherId)
        
        contactsArray = localRealm.objects(ContactModel.self).filter("contactsType = 'Teacher'")
    }
    
    private func setTeacher(teacher: String) {
        let scheeduleOption = self.navigationController?.viewControllers[1] as? ScheduleOptionsTableViewController
        scheeduleOption?.scheduleModel.scheduleTeacher = teacher
        scheeduleOption?.cellNameArray[2][0] = teacher
        scheeduleOption?.tableView.reloadRows(at: [[2,0]], with: .none)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contactsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: teacherId, for: indexPath) as! ContactsTableViewCell
        let model = contactsArray[indexPath.row]
        cell.configure(model: model)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = contactsArray[indexPath.row]
        setTeacher(teacher: model.contactsName)
    }
  
}
