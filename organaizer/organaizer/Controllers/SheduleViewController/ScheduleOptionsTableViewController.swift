//
//  OptionsScheduleViewController.swift
//  organaizer
//
//  Created by Александр Воробей on 27.07.2021.
//

import UIKit

class ScheduleOptionsTableViewController: UITableViewController {
    
    private let idOptionsScheduleCell = "idOptionsScheduleCell"
    private let idOptionsScheduleHeader = "idOptionsScheduleHeader"
    
    var scheduleModel = ScheduleModel()
    
    var hexColorCell = "3802DA"
    
    let headerNameArray = ["DATE AND TIME", "LESSON", "TEACHER", "COLOR", "PERIOD"]
    
    var cellNameArray = [["Date:", "Time:"], ["Name:", "Type:", "Corpuse:", "Auditoria:"], ["Teacher Name:"], [""], ["Repeat every seven days:"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: idOptionsScheduleCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsScheduleHeader)
        
        tableView.backgroundColor = #colorLiteral(red: 0.9272904481, green: 0.9109478226, blue: 0.9396332249, alpha: 1)
        tableView.separatorStyle = .none
        tableView.bounces = false
        
        title = "Options Schedule"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
    }
    
    @objc private func saveButtonTapped() {
        if scheduleModel.scheduleDate == nil || scheduleModel.scheduleTime == nil || scheduleModel.scheduleName == "Unknow" {
            alertOk(title: "Error", message: "Requered DATE, TIME, NAME")
        } else {
            scheduleModel.scheduleColor = hexColorCell
            RealmManager.shared.saveScheduleModel(model: scheduleModel)
            scheduleModel = ScheduleModel()
            alertOk(title: "Save data", message: nil)
            hexColorCell = "3802DA"
            cellNameArray[2][0] = "Teacher Name:"
            tableView.reloadData()
        }
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 2
        case 1: return 4
        case 2: return 1
        case 3: return 1
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsScheduleCell, for: indexPath) as! OptionsTableViewCell
        cell.cellScheduleConfigure(nameArray: cellNameArray, indexPath: indexPath, hexColor: hexColorCell)
        
        cell.switchRepeatDelegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        
        switch indexPath {
        case [0,0]: alertDate(label: cell.nameCellLabel) { numberWeekDay, date in
            self.scheduleModel.scheduleDate = date
            self.scheduleModel.scheduleWeekday = numberWeekDay
        }
        case [0,1]: alertTime(label: cell.nameCellLabel) { time in
            self.scheduleModel.scheduleTime = time
        }
        case [1,0]: alertForCellName(label: cell.nameCellLabel, name: "Name lesson", placeholder: "Enter name lesson") { text in
            self.scheduleModel.scheduleName = text
        }
        case [1,1]: alertForCellName(label: cell.nameCellLabel, name: "Type lesson", placeholder: "Enter type lesson") { text in
            self.scheduleModel.scheduleType = text
        }
        case [1,2]: alertForCellName(label: cell.nameCellLabel, name: "Corpuse number", placeholder: "Enter corpuse number") { text in
            self.scheduleModel.scheduleCorpuse = text
        }
        case [1,3]: alertForCellName(label: cell.nameCellLabel, name: "Auditoria number", placeholder: "Enter auditoria number") { text in
            self.scheduleModel.scheduleAuditoria = text
        }
        case [2,0]: pushControllers(nameVC: TeachersTableViewController())
        case [3,0]: pushControllers(nameVC: ScheduleColorsViewController())
        default:
            print("")
        }
        
    }
    
    func pushControllers(nameVC: UIViewController) {
        let controller = nameVC
        navigationController?.navigationBar.topItem?.title = "Options"
        navigationController?.pushViewController(controller, animated: true)
    }
    
//MARK: - Create Header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsScheduleHeader) as! HeaderOptionsTableViewCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}

extension ScheduleOptionsTableViewController: SwitchRepeatProtocol {
    func switchRepeat(value: Bool) {
        scheduleModel.scheduleRepet = value
    }
    
    
}
