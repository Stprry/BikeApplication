//
//  UserController.swift
//  BikeApplication
//
//  Created by Sam Perry on 04/03/2020.
//  Copyright © 2020 Sam Perry. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
class UserController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func checkIfUserLoggedIn(){
        if Auth.auth().currentUser?.uid == nil{
            
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

  
}
