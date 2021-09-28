//
//  OptionsScheduleTableViewCell.swift
//  organaizer
//
//  Created by Александр Воробей on 27.07.2021.
//

import UIKit

class OptionsTableViewCell: UITableViewCell {
    
    let backgroundViewCell: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.tintColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        repeatSwitch.translatesAutoresizingMaskIntoConstraints = false
        return repeatSwitch
    }()
    
    weak var switchRepeatDelegate: SwitchRepeatProtocol?
    
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
        switchRepeatDelegate?.switchRepeat(value: paramTarget.isOn)
    }
    
    func cellScheduleConfigure(nameArray: [[String]], indexPath: IndexPath, hexColor: String) {
        self.nameCellLabel.text = nameArray[indexPath.section][indexPath.row]
        
        let color = UIColor().colorFromHex(hexColor)
        backgroundViewCell.backgroundColor = (indexPath.section == 3 ? color : .white)
        repeatSwitch.isHidden = (indexPath.section == 4 ? false : true)
        repeatSwitch.onTintColor = color
    }
    
    func cellTasksConfigure(nameArray: [String], indexPath: IndexPath, hexColor: String) {
        self.nameCellLabel.text = nameArray[indexPath.section]
        let color = UIColor().colorFromHex(hexColor)
        backgroundViewCell.backgroundColor = indexPath.section == 3 ? color : .white
    }
    
    func cellContactsConfigure(nameArray: [String], indexPath: IndexPath) {
        self.nameCellLabel.text = nameArray[indexPath.section]
        indexPath.section == 4 ? backgroundViewCell.image = UIImage(systemName: "person.fill.badge.plus") : nil
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

