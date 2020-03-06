//
//  HostRideViewController.swift
//  BikeApplication
//
//  Created by Sam Perry on 06/03/2020.
//  Copyright © 2020 Sam Perry. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class HostRideViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1// change if you want more components in picker, IE: hours seconds minuites
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    @IBOutlet weak var RideTitleLbl: UILabel!
    @IBOutlet weak var RideTitleFeild: UITextField!
    @IBOutlet weak var RideTypeLbl: UILabel!
    @IBOutlet weak var RideTypeBtn: UIButton!
    @IBOutlet weak var RideLeaderLbl: UILabel!
    @IBOutlet weak var RideLeaderSwitch: UISwitch!
    @IBOutlet weak var OtherRideLeaderFeild: UITextField!
    @IBOutlet weak var RideLocationLbl: UILabel!
    @IBOutlet weak var RideLocationSearch: UISearchBar!
    @IBOutlet weak var RideDateLbl: UILabel!
    @IBOutlet weak var RideDateFeild: UITextField!
    @IBOutlet weak var CancelRideBtn: UIButton!
    @IBOutlet weak var SubmitBtn: UIButton!
    @IBOutlet weak var RideTypePicker: UIPickerView!
    @IBOutlet weak var RideDatePicker: UIDatePicker!
    
    /* https://codewithchris.com/uipickerview-example/ */
    var pickerData:[String] = [String]()// declare new array instance to store data acessable in any method ofthe class
    
    override func viewDidLoad() {
        super.viewDidLoad()

      //connecting data
        self.RideTypePicker.delegate = self
        self.RideTypePicker.dataSource = self
        
        //input data into array
        pickerData = ["Down Hill","Enduro","XC","Dirt Jumps","Chill Ride"]
        // hide other leader feild on load
        OtherRideLeaderFeild.isHidden = true
    }
    // The data to return for the row and component (column) that's being passed in
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         return pickerData[row]
     }

    // Capture the picker view selection
     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
            RideTypeBtn.titleLabel?.text = pickerData[row]
      }
    
    @IBAction func RideTypeBtnTap(_ sender: Any) {
         RideTypePicker.isHidden = false
    }
    @IBAction func HidePicker(_ sender: Any) {
        RideTypePicker.isHidden = true
    }
    
    // if im ride leader, fetch details from firebase using my UID for name ect.
    @IBAction func RideLeaderSwitchOn(_ sender: Any) {
       // hide feild for other user search
        if RideLeaderSwitch.isOn{
            OtherRideLeaderFeild.isHidden = true
            // perform databse search for current user info
            let user = Auth.auth().currentUser
            let db = Firestore.firestore()
            if let user = user{
                let uid = user.uid
//                let email = user.email
//                let userRef = db.collection("users").document(uid)
                
                let docRef = db.collection("users").document(uid)
                // Force the SDK to fetch the document from the cache. Could also specify
                // FirestoreSource.server or FirestoreSource.default.
                docRef.getDocument(source: .cache) { (document, error) in
                  if let document = document {
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    print("Cached document data: \(dataDescription)")
                  } else {
                    print("Document does not exist in cache")
                  }
                }

                
                
//                let firstname = db.collection("users").whereField("uid", isEqualTo: uid)
//                          userRef.getDocument { (document, error) in
//                              if let document = document, document.exists {
//                              let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
//                              print("Document data: \(dataDescription)")
//                              var firstname = document.get("firstName")
//                          } else {
//                              print("Document does not exist")
//                          }
//                      }
            }
            
                
                
                // var fn = db.collection("users").document("firstName")
    s
            
        }else{
             // if im NOT ride lead, Get user to enter another users First and Last Name and do an firebase search for a matching user
            OtherRideLeaderFeild.isHidden = false
        }
    }
    @IBAction func RideLeaderSwitchOff(_ sender: Any) {
        
    }
  
    
}
