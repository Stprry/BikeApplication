//
//  PopUpViewController.swift
//  BikeApplication
//
//  Created by Sam Perry on 19/03/2020.
//  Copyright © 2020 Sam Perry. All rights reserved.
//

import UIKit
protocol DateSelectionDelegate {
    func dateSelected(date: String)
}
class PopUpViewController: UIViewController {
   
    var dateDelegate: DateSelectionDelegate!
    var passDate = ""
    /// *OUTLETS*
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var saveBtn: UIButton!
    let currentDateTIme = Date() 
    

    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.minimumDate = currentDateTIme

    }
    
    @IBAction func dateTimeSelect(_ sender: Any) {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "dd/MM/yyyy HH:mm"
        //DatePickerFeild.text = dateformat.string(from: datePicker.date)
        passDate = dateformat.string(from: datePicker.date)
    }
    
    @IBAction func saveDateTap(_ sender: UIButton) {
        if datePicker.date <= currentDateTIme {
            let alert = UIAlertController(title: "Please select a date further from current time!", message: "your selcted time is either in the past or is the current time please select different time!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "change date now", style: .cancel, handler: nil))
            self.present(alert,animated: true)
        }else{
            dateDelegate.dateSelected(date: passDate)
            dismiss(animated: true, completion: nil)
        }
    }
}
//47,173,99
