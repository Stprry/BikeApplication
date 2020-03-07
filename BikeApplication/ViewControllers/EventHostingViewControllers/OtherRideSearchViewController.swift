//
//  OtherRideSearchViewController.swift
//  BikeApplication
//
//  Created by Sam Perry on 07/03/2020.
//  Copyright © 2020 Sam Perry. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class OtherRideSearchViewController: UIViewController {

    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var TableView: UITableView!
    
    
    
    //var riderList = [RiderList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getUsers()
    }
    func getUsers(){// maybe make async?
    let db = Firestore.firestore()
     db.collection("users").getDocuments() { (snapshot, err) in
         if let err = err {
             print("Error getting documents: \(err)")
         } else {
            let documents = snapshot!.documents
            
           try! documents.forEach{document in
                let myUser: MyUser = try document.decoded()
            print(myUser)
            }
         }
     }
  }
    
}
