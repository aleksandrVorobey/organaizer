//
//  ContactModel.swift
//  organaizer
//
//  Created by Александр Воробей on 27.09.2021.
//

import RealmSwift
import Foundation

class ContactModel: Object {
    @Persisted var contactsName = "Unknown"
    @Persisted var contactsPhone = "Unknown"
    @Persisted var contactsMail = "Unknown"
    @Persisted var contactsType = "Unknown"
    @Persisted var contactsImage: Data?
}
