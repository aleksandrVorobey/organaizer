//
//  PressButtonProtocols.swift
//  organaizer
//
//  Created by Александр Воробей on 27.07.2021.
//

import Foundation

protocol PressReadyTaskButtonProtocol: AnyObject {
    func readyButtonTapped(indexPath: IndexPath)
}

protocol SwitchRepeatProtocol: AnyObject {
    func switchRepeat(value: Bool)
}
