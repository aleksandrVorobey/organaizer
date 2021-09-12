//
//  ScheduleModel.swift
//  organaizer
//
//  Created by Александр Воробей on 27.08.2021.
//

import RealmSwift
import Foundation

class ScheduleModel: Object {
    @Persisted var scheduleDate = Date()
    @Persisted var scheduleTime = Date()
    @Persisted var scheduleName: String = "Unknow"
    @Persisted var scheduleType: String = "Unknow"
    @Persisted var scheduleCorpuse: String = "Unknow"
    @Persisted var scheduleAuditoria: String = "Unknow"
    @Persisted var scheduleTeacher: String = "Unknow"
    @Persisted var scheduleColor: String = "3802DA"
    @Persisted var scheduleRepet: Bool = true
    @Persisted var scheduleWeekday: Int = 1
}
