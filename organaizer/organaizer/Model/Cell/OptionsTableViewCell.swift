//
//  OptionsScheduleTableViewCell.swift
//  organaizer
//
//  Created by Александр Воробей on 27.07.2021.
//

import UIKit

class OptionsTableViewCell: UITableViewCell {
    
    let backgroundViewCell: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    let nameCellLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let repeatSwitch: UISwitch = {
       let repeatSwitch = UISwitch()
        repeatSwitch.isOn = true
        repeatSwitch.isHidden = true
        repeatSwitch.onTintColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        repeatSwitch.translatesAutoresizingMaskIntoConstraints = false
        return repeatSwitch
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear

        self.selectionStyle = .none
        
        repeatSwitch.addTarget(self, action: #selector(switchChange), for: .valueChanged)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    @objc func switchChange(paramTarget: UISwitch) {
        if paramTarget.isOn {
            print("On")
        } else {
            print("Off")
        }
    }
    
    func cellScheduleConfigure(nameArray: [[String]], indexPath: IndexPath) {
        self.nameCellLabel.text = nameArray[indexPath.section][indexPath.row]
        if indexPath == [3,0] {
            backgroundViewCell.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        }
        if indexPath == [4,0] {
            repeatSwitch.isHidden = false
        }
    }
    
    func cellTasksConfigure(nameArray: [String], indexPath: IndexPath) {
        self.nameCellLabel.text = nameArray[indexPath.section]
        if indexPath == [3,0] {
            backgroundViewCell.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        }
        
    }


//MARK: - SetConstraints
    func setConstraints() {
        self.addSubview(backgroundViewCell)
        self.addSubview(nameCellLabel)
        self.contentView.addSubview(repeatSwitch)
        
        NSLayoutConstraint.activate([
            backgroundViewCell.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            backgroundViewCell.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            backgroundViewCell.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            backgroundViewCell.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1),
            
            nameCellLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nameCellLabel.leadingAnchor.constraint(equalTo: backgroundViewCell.leadingAnchor, constant: 15),
            
            repeatSwitch.trailingAnchor.constraint(equalTo: backgroundViewCell.trailingAnchor, constant: -20),
            repeatSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

}

