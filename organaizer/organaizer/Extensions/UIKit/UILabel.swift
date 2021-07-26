//
//  UILabel.swift
//  organaizer
//
//  Created by Александр Воробей on 27.07.2021.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont?, alignment:  NSTextAlignment = .left, textColor: UIColor = .black) {
        self.init()
        
        self.text = text
        self.font = font
        self.textAlignment = alignment
        self.textColor = textColor
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

