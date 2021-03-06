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
        imageView.image = UIImage(systemName: "person.fill")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let phoneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "phone.fill")
        return imageView
    }()
    
    let mailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "envelope.fill")
        return imageView
    }()
    
    let nameLabel = UILabel(text: "Unknown", font: .avenirNext20())
    let phoneLabel = UILabel(text: "Unknown", font: .avenirNext14())
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
    
    func configure(model: ContactModel) {
        nameLabel.text = model.contactsName
        phoneLabel.text = model.contactsPhone
        mailLabel.text = model.contactsMail
        if let data = model.contactsImage, let image = UIImage(data: data) {
            contactImageView.image = image
        } else {
            contactImageView.image = UIImage(systemName: "person.fill")
        }
    }

    //MARK: - SetConstraints
        func setConstraints() {
            self.addSubview(contactImageView)
            self.addSubview(nameLabel)
            
            let stackView = UIStackView(arrangedSubviews: [phoneImageView, phoneLabel, mailImageView, mailLabel], axis: .horizontal, spacing: 3, distribution: .equalSpacing)
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

