//
//  TaskModel.swift
//  organaizer
//
//  Created by Александр Воробей on 27.09.2021.
//

import RealmSwift
import Foundation

class TaskModel: Object {
    @Persisted var taskDate: Date?
    @Persisted var taskName: String = "Unknow"
    @Persisted var taskDescription: String = "Unknow"
    @Persisted var taskColor: String = "3802DA"
    @Persisted var taskReady: Bool = false
}
