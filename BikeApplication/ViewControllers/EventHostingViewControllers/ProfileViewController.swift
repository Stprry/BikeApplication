//
//  ProfileViewController.swift
//  BikeApplication
//
//  Created by Sam Perry on 11/03/2020.
//  Copyright © 2020 Sam Perry. All rights reserved.
//

import UIKit
import Foundation
import Firebase

protocol RiderSelectionDelegate {
    func selectedRideLeader(firstName:String,lastName:String,uid:String)
}
class ProfileViewController: UIViewController {
    @IBOutlet weak var ProfilePictureImageView: UIImageView!
    @IBOutlet weak var AddasLeaderBtn: UIButton!
    @IBOutlet weak var FirstNameFeild: UILabel!
    @IBOutlet weak var LastNameFeild: UILabel!
    @IBOutlet weak var UserBioFeild: UILabel!
    @IBOutlet weak var HiddenEmail: UILabel!
    @IBOutlet weak var HiddenUID: UILabel!
    
    var user: MyUser?
    var selectedFirstName: String?
    var selectedLastName: String?
    var selectedUID: String?
    var selectedEmail: String?
    var selectionDelegate: RiderSelectionDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// make profile picture circular
        ProfilePictureImageView.layer.cornerRadius = ProfilePictureImageView.frame.size.width/2
        ProfilePictureImageView.clipsToBounds = true
       /// load user data into view
        FirstNameFeild?.text = user?.firstName
        LastNameFeild?.text = user?.lastName
        HiddenUID?.text = user?.uid
        HiddenEmail?.text = user?.email
    }
    @IBAction func SelectedLeaderpressed(_ sender: Any) {
        selectedFirstName = FirstNameFeild.text
        selectedLastName = LastNameFeild.text
        selectedUID = user?.uid
        selectedEmail = user?.email
        
        print(selectedUID!,selectedLastName!,selectedFirstName!)
        selectionDelegate.selectedRideLeader(firstName: selectedFirstName!, lastName: selectedLastName!, uid: selectedUID!)
        //dismiss(animated: true, completion: nil)
        perform(#selector(advance),with: nil,afterDelay: 0)
    }
    @objc func advance(){
        let otherVC = storyboard?.instantiateViewController(withIdentifier: "ORSearchVC") as! OtherRideSearchViewController
        dismiss(animated: true, completion: nil)
        present(otherVC, animated: true, completion: nil)
    }
}

