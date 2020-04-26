//
//  RideEventViewController.swift
//  BikeApplication
//
//  Created by Sam Perry on 24/03/2020.
//  Copyright © 2020 Sam Perry. All rights reserved.
//
import Firebase
import FirebaseAuth
import UIKit
import MapKit
class RideEventViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    var rideCorords: CLLocationCoordinate2D?
    let db = Firestore.firestore()

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var rideNameLbl: UILabel!
    @IBOutlet weak var rideLeaderLbl: UILabel!
    @IBOutlet weak var rideTypeLbl: UILabel!
    @IBOutlet weak var rideAttendeesLbl: UILabel!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var userTable: UITableView!
   
    let ref = Firestore.firestore().collection("EventAttendees")
    var myUsers:[AttendingUser] = [] // declaring array
    var docID = ""// declare doc ID for future use for creating collection and querying that collection beacuse its uinque!
    var rideDate = ""// declare ride date for future use in Event Attendees, will be used to delete out of date rides.
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("my ride corordinates \(rideCorords)")
        fetchData()
        userTable.dataSource = self
        userTable.delegate = self
        getUsers()
        // Do any additional setup after loading the view.
        // query firebase with co-ord details to get the specific ride info
    }
// -MARK: Sign Up Btn
    @IBAction func signUpBtnTap(_ sender: Any) {
        // create firebase atendee add atendee to the ride attendee,
        let user = (Auth.auth().currentUser?.displayName)!
//        let attend = "Attendees"
//        //db.collection("Events").document(docID).collection("Attendees").addocument("userID")
//        db.collection("Events").document(docID).collection(attend).addDocument(data: user)
        db.collection("EventAttendees").addDocument(data: ["docIDFromRide":docID,"rideDate":rideDate,"uid":Auth.auth().currentUser?.uid,"displayName":Auth.auth().currentUser?.displayName]) { (error) in
            if error != nil{
                // error in database show error could impliment in label
                print("Something went wrong on our servers")
            }
            self.refresh()
        }
    }
    func refresh(){
        userTable.reloadData()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myUsers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "attendCell", for: indexPath)
        let user = myUsers[indexPath.row]
        cell.textLabel?.text = user.displayName
        return cell
    }
}
// -MARK: loading data into the page of the ride they clicked on
extension RideEventViewController{
    func fetchData(){
        let db = Firestore.firestore()
        let dbRef = db.collection("Events")
        dbRef
            .whereField("rideYCordinate", isEqualTo: rideCorords?.latitude as Any)
            .whereField("rideXCordinate", isEqualTo: rideCorords?.longitude as Any)
            .getDocuments() { (querySnapshot, err) in
                  if let err = err {
                      print("Error getting documents: \(err)")
                  } else {
                      for document in querySnapshot!.documents {
                         // print("\(document.documentID) => \(document.data())")// pull down all the data from the document, store it in constants
                       let rideleaderAny = document.get("rideLeader")
                        let rideDateAny = document.get("rideDate")
                        _ = document.get("rideLeaderUID")
                        let rideLocationAny = document.get("rideLocation")
                        let rideNameAny = document.get("rideName")
                        let rideTypeAny = document.get("rideType")
                        self.rideDate = rideDateAny as! String// add rideDate our of scope to store to eventAttendees
                        self.docID = document.documentID
                        print(self.docID)
                        self.rideLeaderLbl.text = "Ride leader: \(rideleaderAny as! String) "// force downcast into string and assign to labels
                        self.rideNameLbl.text = "\(rideNameAny as! String) : \(rideDateAny as! String)"
                        self.rideTypeLbl.text = "Ride Type: \(rideTypeAny as! String)"
                      }
                  }
          }
    }
}
// -MARK: fetching users for table  for the ride they clicked on
extension RideEventViewController{
    func getUsers(){
        let db = Firestore.firestore()
        let eventRef = db.collection("EventAttendees")
        eventRef.whereField("docIDFromRide", isEqualTo: docID)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                        let dn = document.get("displayName")
                        let uid = document.get("uid")
                        print("\(dn) \(uid)")
                        let myUser: AttendingUser = try! document.decoded()
                        self.myUsers.append(myUser)
                    }
                    self.userTable.reloadData()
            }
        }
    }
}
