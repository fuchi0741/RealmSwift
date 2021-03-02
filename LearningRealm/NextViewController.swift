//
//  NextViewController.swift
//  LearningRealm
//
//  Created by 渕一真 on 2021/03/02.
//

import UIKit
import RealmSwift

class NextViewController: UIViewController {
    
    @IBOutlet weak var todoTitleTF: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker! {
        didSet {
            datePicker.timeZone = TimeZone.current //今の時間に合わせる
            datePicker.locale = Locale.current
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapSendButton(_ sender: UIButton) {
        TodoItemManager().save(title: todoTitleTF.text!, date: datePicker.date)
        dismiss(animated: true, completion: nil)
    }
}
