//
//  TodoItemManager.swift
//  LearningRealm
//
//  Created by 渕一真 on 2021/03/02.
//

import Foundation
import RealmSwift
import NotificationCenter

class TodoItemManager {
    let realm = try! Realm()
    
    func save(title: String, date: Date) {
        let item = TodoItem()
        item.id = String(Int.random(in: 0...9999))
        item.title = title
        item.date = date
        
        try! realm.write {
            realm.add(item)
        }
        setNotification(item: item)
    }
    
    // 4分ごろの動画
    func delete(item: TodoItem, token: NotificationToken) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [item.id])
        try! realm.write(withoutNotifying: [token]) {
            realm.delete(item)
        }
    }
    
    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd HH:mm"
        return formatter.string(from: date)
    }
    
    func setNotification(item: TodoItem) {
        let targetDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: item.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: targetDate, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = item.title
        content.sound = .default
        let request = UNNotificationRequest(identifier: item.id,
                                            content: content,
                                            trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
}
