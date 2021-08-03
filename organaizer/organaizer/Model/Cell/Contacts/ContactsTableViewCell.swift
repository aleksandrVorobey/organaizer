//
//  ContactsTableViewCell.swift
//  organaizer
//
//  Created by Александр Воробей on 02.08.2021.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {
    
    let contactImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "face")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let phoneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "phone.fill")
        imageView.tintColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let mailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "envelope.fill")
        imageView.tintColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nameLabel = UILabel(text: "James Bond", font: .avenirNext20())
    let phoneLabel = UILabel(text: "8999 222 33 44", font: .avenirNext14())
    let mailLabel = UILabel(text: "jamesBond@mail.com", font: .avenirNext14())
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        contactImageView.layer.cornerRadius = contactImageView.frame.height / 2
    }
    
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
            self.addSubview(contactImageView)
            self.addSubview(nameLabel)
            
            let stackView = UIStackView(arrangedSubviews: [phoneImageView, phoneLabel, mailImageView, mailLabel], axis: .horizontal, spacing: 3, distribution: .fillProportionally)
            self.addSubview(stackView)
            
            NSLayoutConstraint.activate([
                contactImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
                contactImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
                contactImageView.heightAnchor.constraint(equalToConstant: 70),
                contactImageView.widthAnchor.constraint(equalToConstant: 70),
                
                nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
                nameLabel.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: 10),
                nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
                nameLabel.heightAnchor.constraint(equalToConstant: 21),
                
                stackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
                stackView.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: 10),
                stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
                stackView.heightAnchor.constraint(equalToConstant: 21)
            ])
        }
    
}

