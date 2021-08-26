//
//  TasksOptionScheduleTableViewController.swift
//  organaizer
//
//  Created by Александр Воробей on 02.08.2021.
//

import UIKit

class TasksOptionsTableViewController: UITableViewController {
    
    private let idOptionsTasksCell = "idOptionsTasksCell"
    private let idOptionsTasksHeader = "idOptionsTasksHeader"
    
    let headerNameArray = ["DATE", "LESSON", "TASK", "COLOR"]
    
    let cellNameArray = ["Date", "Lesson", "Task", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier: idOptionsTasksCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsTasksHeader)
        
        tableView.backgroundColor = #colorLiteral(red: 0.9272904481, green: 0.9109478226, blue: 0.9396332249, alpha: 1)
        tableView.separatorStyle = .none
        tableView.bounces = false
        
        title = "Options tasks"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsTasksCell, for: indexPath) as! OptionsTableViewCell
        cell.cellTasksConfigure(nameArray: cellNameArray, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        
        switch indexPath.section {
        case 0: alertDate(label: cell.nameCellLabel) { numberWeekDay, date in
            print(date)
        }
        case 1: alertForCellName(label: cell.nameCellLabel, name: "Name lesson", placeholder: "Enter name lesson")
        case 2: alertForCellName(label: cell.nameCellLabel, name: "Name task", placeholder: "Enter name task")
        case 3: pushControllers(nameVC: TaskColorsTableViewController())
        default:
            print("prapapa")
        }

    }
    
    func pushControllers(nameVC: UIViewController) {
        let controller = nameVC
        navigationController?.navigationBar.topItem?.title = "Options"
        navigationController?.pushViewController(controller, animated: true)
    }
    
//MARK: - Create Header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsTasksHeader) as! HeaderOptionsTableViewCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}

