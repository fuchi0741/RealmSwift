//
//  TodoItem.swift
//  LearningRealm
//
//  Created by 渕一真 on 2021/03/02.
//

import Foundation
import RealmSwift

class TodoItem: Object {
    @objc dynamic var id = ""
    @objc dynamic var title = ""
    @objc dynamic var date = Date()
}
