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
    var cellNameArray = ["Name", "Phone", "Mail", "Type", ""]
    
    var imageIsChanged = false
    var contactModel = ContactModel()
    var editModel = false
    var dataImage: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Options contacts"
        
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
        if cellNameArray[0] == "Name" || cellNameArray[3] == "Type" {
            alertOk(title: "Error", message: "Requered fields: NAME and TYPE")
        } else if editModel == false {
            setImageModel()
            setModel()
            RealmManager.shared.saveContactModel(model: contactModel)
            contactModel = ContactModel()
            cellNameArray = ["Name", "Phone", "Mail", "Type", ""]
            alertOk(title: "Succsess", message: nil)
            tableView.reloadData()
        } else {
            setImageModel()
            RealmManager.shared.updateContactModel(model: contactModel, nameArray: cellNameArray, imageData: dataImage)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func setModel() {
        contactModel.contactsName = cellNameArray[0]
        contactModel.contactsPhone = cellNameArray[1]
        contactModel.contactsMail = cellNameArray[2]
        contactModel.contactsType = cellNameArray[3]
        contactModel.contactsImage = dataImage
    }
    
    private func setImageModel() {
        if imageIsChanged {
            let cell = tableView.cellForRow(at: [4,0]) as? OptionsTableViewCell
            let image = cell?.backgroundViewCell.image
            guard let imageData = image?.pngData() else { return }
            dataImage = imageData
            
            cell?.backgroundViewCell.contentMode = .scaleAspectFit
            imageIsChanged = false
        } else {
            dataImage = nil
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
        
        if editModel == false {
            cell.cellContactsConfigure(nameArray: cellNameArray, indexPath: indexPath, image: nil)
        } else if let data = contactModel.contactsImage, let image = UIImage(data: data) {
            cell.cellContactsConfigure(nameArray: cellNameArray, indexPath: indexPath, image: image)
        } else {
            cell.cellContactsConfigure(nameArray: cellNameArray, indexPath: indexPath, image: nil)
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 4 ? 200 : 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell

        switch indexPath.section {
        case 0: alertForCellName(label: cell.nameCellLabel, name: "Name contact", placeholder: "Enter name contact") { text in
            self.cellNameArray[0] = text
        }
        case 1: alertForCellName(label: cell.nameCellLabel, name: "Phone contact", placeholder: "Enter phone contact") { text in
            self.cellNameArray[1] = text
        }
        case 2: alertForCellName(label: cell.nameCellLabel, name: "Mail contact", placeholder: "Enter mail contact") { text in
            self.cellNameArray[2] = text
        }
        case 3: alertFriendOrTeacher(label: cell.nameCellLabel) { type in
            self.cellNameArray[3] = type
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
