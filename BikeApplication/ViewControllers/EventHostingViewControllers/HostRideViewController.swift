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


class HostRideViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 /// change if you want more components in picker, IE: hours seconds minuites
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    /// let return button close keyboard
      func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          textField.resignFirstResponder()
          return true;
      }
    
    @IBOutlet weak var RideTitleLbl: UILabel!
    @IBOutlet weak var RideTitleFeild: UITextField!
    @IBOutlet weak var RideTypeLbl: UILabel!
    @IBOutlet weak var RideTypeBtn: UIButton!
    @IBOutlet weak var RideLeaderLbl: UILabel!
    @IBOutlet weak var RideLeaderSwitch: UISwitch!
    @IBOutlet weak var OtherRideLeaderBtn: UIButton!
    @IBOutlet weak var RideLocationLbl: UILabel!
    @IBOutlet weak var RideLocationLabel: UILabel!
    @IBOutlet weak var RideDateLbl: UILabel!
    @IBOutlet weak var CancelRideBtn: UIButton!
    @IBOutlet weak var SubmitBtn: UIButton!
    @IBOutlet weak var RideTypePicker: UIPickerView!
    @IBOutlet weak var RideTypeSelection: UILabel!
    @IBOutlet weak var OtherRideLeaderLbl: UILabel!
    @IBOutlet weak var DateFeild: UILabel!
    @IBOutlet weak var ErrorLabel: UILabel!
    
    /* https://codewithchris.com/uipickerview-example/ */
    ///private var ( to this clas)
    ///
    ///public var (to this class)
    var pickerData:[String] = [String]()///  declare new array instance to store data acessable in any method of the class
    var SelectedRideLeaderUser: MyUser?
    var selectedType:String?
    var otherRiderFirstName:String?
    var otherRiderLastName:String?
    var otherRiderUID:String?
    var rideAdress:String?
    var othercomboName:String?
    
    ///*VIEW DID LOAD*
    override func viewDidLoad() {
        super.viewDidLoad()
      ///connecting data
        self.RideTypePicker.delegate = self
        self.RideTypePicker.dataSource = self
        RideTitleFeild.delegate = self
        ///input data into array
        pickerData = ["Down Hill","Enduro","XC","Dirt Jumps","Chill Ride"]
        /// hide other leader feild on load
        RideTypeSelection.isHidden = true
        
        ///*CUSTOM TAP GEUSTER RECOGNISERS*
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
           tap.numberOfTapsRequired = 2
           view.addGestureRecognizer(tap)
        
        let ridelblTap = UITapGestureRecognizer(target: self, action: #selector(ridelblTapSuege))
                               ridelblTap.numberOfTapsRequired = 1
                     RideLocationLabel.addGestureRecognizer(ridelblTap)
        
        let rideDateTap = UITapGestureRecognizer(target: self, action: #selector(tapDateLabel))
                                      rideDateTap.numberOfTapsRequired = 1
                            DateFeild.addGestureRecognizer(rideDateTap)
    }
    
    ///*@OJC FUNCTIONS*
    /// func to seuge to location search
 @objc func ridelblTapSuege(){
        print("tapguester Tap")
        let locationVC = storyboard?.instantiateViewController(withIdentifier: "LocationSearchVC") as! LocationSearchViewController
        locationVC.passAdressDelegate = self
        present(locationVC, animated: true, completion: nil)
    }
    /// hide the picker on a double tap if its shown
    @objc func doubleTapped(gestureRecognizer: UITapGestureRecognizer) {
        if RideTypePicker.isHidden == false {
            RideTypePicker.isHidden = true
        }
    }
    @objc func tapDateLabel(tap:UITapGestureRecognizer){
        // show picker popup here!
        print("test tap")
        let popUpVC =  storyboard?.instantiateViewController(withIdentifier: "PopupID") as! PopUpViewController
        popUpVC.modalPresentationStyle = .overCurrentContext
        popUpVC.dateDelegate = self
        present(popUpVC, animated: true, completion: nil)
    }
    
    ///* FORM FUNCTIONS*
    /// The data to return for the row and component (column) that's being passed in
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         return pickerData[row]
     }
    
    /// Capture the picker view selection
     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
            //RideTypeBtn.titleLabel?.text = pickerData[row]
        RideTypeSelection.text = pickerData[row]
        selectedType = pickerData[row]
      }
    
    func submitData() {
        let db = Firestore.firestore()
        let rideName = RideTitleFeild.text
        let rideType = RideTypeSelection.text
        var rideLeader = ""
        var uid = ""
        let rideLocation = rideAdress
        let date = DateFeild.text
        // fix optional leader name
        if RideLeaderSwitch.isOn{
            rideLeader = (Auth.auth().currentUser?.displayName)!
            uid = Auth.auth().currentUser!.uid
        }
        else
        {
            rideLeader = othercomboName!
            uid = otherRiderUID!
        }
        db.collection("Events").addDocument(data: ["rideName":rideName!,"rideType":rideType!,"rideLeader":rideLeader,"rideLeaderUID":uid,"rideLocation":rideLocation!,"rideDate":date!]) { (error) in
            if error != nil{
                // error in database show error
                print("Something went wrong on our servers, First name or last name had something wrong")
            }
        }
    }
    
    ///*ACTION FUNCTIONS FROM BUTTOSN LABELS ECT*
    /// show corrisponding pickers and labels when tapped
    @IBAction func RideTypeBtnTap(_ sender: Any) {
         RideTypePicker.isHidden = false
        RideTypeSelection.isHidden = false
        RideTypeBtn.isHidden = true
    }
    
    /// if im ride leader, fetch details from firebase using my UID for name ect.
    @IBAction func RideLeaderSwitchOn(_ sender: Any) {
       /// hide feild for other user search
        if RideLeaderSwitch.isOn{
            OtherRideLeaderLbl.isHidden = true
            OtherRideLeaderBtn.isHidden = true
            }else{
             /// if im NOT ride lead, Get user to enter another users First and Last Name and do an firebase search for a matching user
            OtherRideLeaderBtn.isHidden = false
            OtherRideLeaderLbl.isHidden = false
        }
    }
    
    /// check if feilds are empty, if not empty submit data
    @IBAction func SubmitRideEvent(_ sender: Any) {
        if RideTitleLbl.text == "" || DateFeild.text == "" || RideTypeSelection.text == "" || RideLocationLabel.text == ""{
            ErrorLabel.text = "please enter details in all feilds"
        }else
        {
            submitData()
            let alert = UIAlertController(title: "Your ride has been sucsessfully created!", message: "please check the events logs for you event details!", preferredStyle: .alert)
            //alert.addAction(UIAlertAction(title: "Great!", style: .default, handler: nil))
            self.present(alert,animated: true)
            // Delay the dismissal by 3 seconds
          let when = DispatchTime.now() + 2
          DispatchQueue.main.asyncAfter(deadline: when){
            // code with delay
            alert.dismiss(animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
          }
        }
    }
    
    /// seuge to search page, create delegates accordingly
    @IBAction func OtherRideLeaderTap(_ sender: Any) {
        /// DELEGATES ProfileVC -> OtherRiderSearchVC-> This VC 3 required.
        let riderSearchVC = storyboard?.instantiateViewController(identifier: "ORSearchVC") as! OtherRideSearchViewController
              riderSearchVC.passDelegate = self
        present(riderSearchVC, animated: true, completion: nil)
        OtherRideLeaderLbl.isHidden = false
    }
    ///Shows the picker view for ride type
    @IBAction func showPickerTap(_ sender: Any) {
        RideTypePicker.isHidden = false
    }
}
///*EXTENSION DELEGATES*
extension HostRideViewController:PasstoHostDelegate{
    func passDataToHost(firstName: String, lastName: String, uid: String) {
        print(lastName,firstName,uid)
        let comboName = "\(firstName)  \(lastName)"
        othercomboName = comboName
        OtherRideLeaderLbl.text = "\(comboName)"
        OtherRideLeaderLbl.textColor = UIColor(named: "DefaultGreen")
        otherRiderFirstName = firstName
        otherRiderLastName = lastName
        otherRiderUID = uid
    }
}

extension HostRideViewController:AdressPassbackDelegate{
    func passAdress(adress: String) {
        RideLocationLabel.text = "Ride Location: \(adress)"
        RideLocationLabel.textColor = UIColor(named: "DefaultGreen")
        rideAdress = adress
    }
}

extension HostRideViewController:DateSelectionDelegate{
    func dateSelected(date: String) {
        DateFeild.text = date
        DateFeild.textColor = UIColor(named: "DefaultGreen")
    }
}
