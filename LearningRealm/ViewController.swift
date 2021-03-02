//
//  ViewController.swift
//  LearningRealm
//
//  Created by 渕一真 on 2021/03/02.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    var itemList: Results<TodoItem>!
    let realm = try! Realm()
    var token: NotificationToken!
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemList = realm.objects(TodoItem.self).sorted(byKeyPath: "date")
        token = realm.observe { notification, realm in
            //変更があった場合にTableViewを更新
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    //このメソッドはCellの数の分呼ばれる
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = itemList[indexPath.row] //このコードは自分にとって新らしいコード
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = TodoItemManager().dateToString(date: item.date)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            TodoItemManager().delete(item: itemList[indexPath.row], token: token)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}



