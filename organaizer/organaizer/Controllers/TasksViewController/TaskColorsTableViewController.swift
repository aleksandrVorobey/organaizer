//
//  ColorTaskTableViewController.swift
//  organaizer
//
//  Created by Александр Воробей on 02.08.2021.
//

import UIKit

class TaskColorsTableViewController: UITableViewController {
    
    private let idTasksColorCell = "idTasksColorCell"
    private let idTaskColorHeader = "idTaskColorHeader"
    
    let headerNameArray = ["RED", "ORANGE", "YELLOW", "GREEN", "BLUE", "DEEP BLUE", "PURPLE"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Colors tasks"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = #colorLiteral(red: 0.9272904481, green: 0.9109478226, blue: 0.9396332249, alpha: 1)
        tableView.separatorStyle = .none
        tableView.bounces = false
        
        tableView.register(ColorsTableViewCell.self, forCellReuseIdentifier: idTasksColorCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idTaskColorHeader)
    }
    
    private func setColor(color: String) {
        let taskOptions = self.navigationController?.viewControllers[1] as? TasksOptionsTableViewController
        taskOptions?.hexColorCell = color
        taskOptions?.tableView.reloadRows(at: [[3,0]], with: .none)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idTasksColorCell, for: indexPath) as! ColorsTableViewCell
        cell.cellConfigure(indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = tableView.cellForRow(at: indexPath) as! ColorsTableViewCell
        
        switch indexPath.section {
        case 0: setColor(color: "851C0D")
        case 1: setColor(color: "BE2813")
        case 2: setColor(color: "F3AF22")
        case 3: setColor(color: "467C24")
        case 4: setColor(color: "1A4766")
        case 5: setColor(color: "3802DA")
        case 6: setColor(color: "8E5AF7")
        default:
            setColor(color: "FFFFFF")
        }
    }
    
    
//MARK: - Create Header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idTaskColorHeader) as! HeaderOptionsTableViewCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
}



