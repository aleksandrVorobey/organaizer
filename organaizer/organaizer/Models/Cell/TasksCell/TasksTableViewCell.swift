//
//  TasksTableViewCell.swift
//  organaizer
//
//  Created by Александр Воробей on 27.07.2021.
//

import UIKit

class TasksTableViewCell: UITableViewCell {
    
    let taskName = UILabel(text: "Programing", font: .avenirNextDemiBold20())
    let taskDescription = UILabel(text: "Leaning english lesson", font: .avenirNext14())
    
    let readyButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "chevron.down.square"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var cellTaskDelegate: PressReadyTaskButtonProtocol?
    var index: IndexPath?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        taskDescription.numberOfLines = 2
        
        readyButton.addTarget(self, action: #selector(readyButtonTapped), for: .touchUpInside)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func readyButtonTapped() {
        guard let index = index else { return }
        cellTaskDelegate?.readyButtonTapped(indexPath: index)
    }
    
    func configure(model: TaskModel) {
        taskName.text = model.taskName
        taskDescription.text = model.taskDescription
        backgroundColor = UIColor().colorFromHex(model.taskColor)
        
        if model.taskReady {
            readyButton.setBackgroundImage(UIImage(systemName: "chevron.down.circle.fill"), for: .normal)
        } else {
            readyButton.setBackgroundImage(UIImage(systemName: "chevron.down.circle"), for: .normal)
        }
    }

    //MARK: - SetConstraints
        func setConstraints() {
            self.contentView.addSubview(readyButton)
            self.addSubview(taskName)
            self.addSubview(taskDescription)
            
            NSLayoutConstraint.activate([
                readyButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                readyButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
                readyButton.widthAnchor.constraint(equalToConstant: 40),
                readyButton.heightAnchor.constraint(equalToConstant: 40),
                
                taskName.centerYAnchor.constraint(equalTo: readyButton.topAnchor),
                taskName.trailingAnchor.constraint(equalTo: readyButton.leadingAnchor, constant: -5),
                taskName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
                taskName.heightAnchor.constraint(equalToConstant: 25),
                
                taskDescription.topAnchor.constraint(equalTo: taskName.bottomAnchor, constant: 5),
                taskDescription.trailingAnchor.constraint(equalTo: readyButton.leadingAnchor, constant: -5),
                taskDescription.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
                //taskDescription.heightAnchor.constraint(equalToConstant: 25)
            ])
        }
    
}
