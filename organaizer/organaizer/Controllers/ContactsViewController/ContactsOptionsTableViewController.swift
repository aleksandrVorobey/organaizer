//
//  ContactsOptionTableViewController.swift
//  organaizer
//
//  Created by Александр Воробей on 03.08.2021.
//

import UIKit

class ContactsOptionsTableViewController: UITableViewController {
    
    private let idOptionsContactsCell = "idOptionsContactsCell"
    private let idOptionsContactsHeader = "idOptionsContactsHeader"
    
    let headerNameArray = ["NAME", "PHONE", "MAIL", "TYPE", "CHOOSE IMAGE"]
    let cellNameArray = ["Name", "Phone", "Mail", "Type", ""]
    
    private var imageIsChanged = false
    private var contactModel = ContactModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Options tasks"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: idOptionsContactsCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsContactsHeader)
        
        tableView.backgroundColor = #colorLiteral(red: 0.9272904481, green: 0.9109478226, blue: 0.9396332249, alpha: 1)
        tableView.separatorStyle = .none
        tableView.bounces = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
    }
    
    @objc func saveButtonTapped() {
        if contactModel.contactsName == "Unknown" || contactModel.contactsType == "Unknown" {
            alertOk(title: "Error", message: "Requered fields: NAME and TYPE")
        } else {
            setImageModel()
            RealmManager.shared.saveContactModel(model: contactModel)
            contactModel = ContactModel()
            alertOk(title: "Succsess", message: nil)
            tableView.reloadData()
        }
    }
    
    private func setImageModel() {
        if imageIsChanged {
            let cell = tableView.cellForRow(at: [4,0]) as? OptionsTableViewCell
            let image = cell?.backgroundViewCell.image
            guard let imageData = image?.pngData() else { return }
            contactModel.contactsImage = imageData
            
            cell?.backgroundViewCell.contentMode = .scaleAspectFit
            imageIsChanged = false
        } else {
            contactModel.contactsImage = nil
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsContactsCell, for: indexPath) as! OptionsTableViewCell
        cell.cellContactsConfigure(nameArray: cellNameArray, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 4 ? 200 : 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell

        switch indexPath.section {
        case 0: alertForCellName(label: cell.nameCellLabel, name: "Name contact", placeholder: "Enter name contact") { text in
            self.contactModel.contactsName = text
        }
        case 1: alertForCellName(label: cell.nameCellLabel, name: "Phone contact", placeholder: "Enter phone contact") { text in
            self.contactModel.contactsPhone = text
        }
        case 2: alertForCellName(label: cell.nameCellLabel, name: "Mail contact", placeholder: "Enter mail contact") { text in
            self.contactModel.contactsMail = text
        }
        case 3: alertFriendOrTeacher(label: cell.nameCellLabel) { type in
            self.contactModel.contactsType = type
        }
        case 4: alertPhotoOrCamera { source in
            self.chooseImagePicker(sourse: source)
        }
        default:
            print("prapapa")
        }

    }
    
//MARK: - Create Header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsContactsHeader) as! HeaderOptionsTableViewCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}

extension ContactsOptionsTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func chooseImagePicker(sourse: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourse) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = sourse
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let cell = tableView.cellForRow(at: [4,0]) as! OptionsTableViewCell
        cell.backgroundViewCell.image = info[.editedImage] as? UIImage
        cell.backgroundViewCell.contentMode = .scaleAspectFill
        cell.backgroundViewCell.clipsToBounds = true
        imageIsChanged = true
        dismiss(animated: true, completion: nil)
    }
}
