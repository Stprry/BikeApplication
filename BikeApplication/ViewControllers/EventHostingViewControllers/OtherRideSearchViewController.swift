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
protocol PasstoHostDelegate {
    func passDataToHost(firstName:String,lastName:String,uid:String)
}
class OtherRideSearchViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var TableView: UITableView!
    var myUsers:[MyUser] = []
    var selectFirstName:String?
    var selectLastName:String?
    var selectUID:String?
    
    var passDelegate:PasstoHostDelegate!///delegate to host

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getUsers()
        TableView.dataSource = self
        TableView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
 func getUsers(){
        let db = Firestore.firestore()
        db.collection("users").getDocuments() { (snapshot, err) in
        if let err = err {
            print("Error getting documents: \(err)")
        } else {
            let documents = snapshot!.documents
            try! documents.forEach{document in
                let myUser: MyUser = try document.decoded()
                print(myUser.firstName)
                //3.)Appending the data to the array
                self.myUsers.append(myUser)
            }
            //4.) Reloading your tableview AFTER the foreach
            self.TableView.reloadData()
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RiderListCell", for: indexPath)
        let user = myUsers[indexPath.row]
        cell.textLabel!.text = user.firstName
        cell.detailTextLabel?.text = user.lastName
        
        return cell
    }
// sends user data with seuge and index of table view to the user profile page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let profileViewController = segue.destination as? ProfileViewController,
        let index = TableView.indexPathForSelectedRow?.row
        else {
            return
        }
        profileViewController.user = myUsers[index]
        profileViewController.selectionDelegate = self
    }
    @objc func advance(){
         passDelegate.passDataToHost(firstName: selectFirstName!, lastName: selectLastName!, uid: selectUID!)
        dismiss(animated: true, completion: nil)
    }
}
extension OtherRideSearchViewController:RiderSelectionDelegate{
    func selectedRideLeader(firstName: String, lastName: String, uid: String) {
        print(firstName,uid,lastName)
        selectUID = uid
        selectLastName = lastName
        selectFirstName = firstName
        perform(#selector(advance),with:nil,afterDelay: 1)
    }
}

