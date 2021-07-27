//
//  ScheduleTableViewCell.swift
//  organaizer
//
//  Created by Александр Воробей on 26.07.2021.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {
    
    let lessonName = UILabel(text: "Programming", font: .avenirNextDemiBold20())
    
    let teacherName = UILabel(text: "Sidorov Ivan Petrovich", font: .avenirNextDemiBold20(), alignment: .right)
        
    let lessonTime = UILabel(text: "08:00", font: .avenirNextDemiBold20())
    
    let typeLabel = UILabel(text: "Type:", font: .avenirNextDemiBold14(), alignment: .right)
    
    let lessonType = UILabel(text: "Lection", font: .avenirNext14())
        
    let buildingLabel = UILabel(text: "Courpus:", font: .avenirNextDemiBold14(), alignment: .right)
    
    let lessonBuilding = UILabel(text: "1", font: .avenirNext14())
       
    let audLabel = UILabel(text: "Auditoria:", font: .avenirNextDemiBold14(), alignment: .right)
        
    let lessonAud = UILabel(text: "101", font: .avenirNext14())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.selectionStyle = .none
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//MARK: - SetConstraints
    func setConstraints() {
        let topStackView = UIStackView(arrangedSubviews: [lessonName, teacherName], axis: .horizontal, spacing: 10, distribution: .fillEqually)
        
        let bottomStackView = UIStackView(arrangedSubviews: [typeLabel, lessonType, buildingLabel, lessonBuilding, audLabel, lessonAud], axis: .horizontal, spacing: 5, distribution: .fillProportionally)
        
        self.addSubview(topStackView)
        self.addSubview(bottomStackView)
        self.addSubview(lessonTime)
        
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            topStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            topStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            topStackView.heightAnchor.constraint(equalToConstant: 25),
            
            lessonTime.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            lessonTime.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            lessonTime.widthAnchor.constraint(equalToConstant: 100),
            lessonTime.heightAnchor.constraint(equalToConstant: 25),
            
            bottomStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            bottomStackView.leadingAnchor.constraint(equalTo: lessonTime.trailingAnchor, constant: 5),
            bottomStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            bottomStackView.heightAnchor.constraint(equalToConstant: 25),
        ])
    }

}
