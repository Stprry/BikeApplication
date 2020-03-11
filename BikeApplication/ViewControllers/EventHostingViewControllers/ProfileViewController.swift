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

class ProfileViewController: UIViewController {

    @IBOutlet weak var ProfilePictureImageView: UIImageView!
    @IBOutlet weak var AddasLeaderBtn: UIButton!
    @IBOutlet weak var FirstNameFeild: UILabel!
    @IBOutlet weak var LastNameFeild: UILabel!
    @IBOutlet weak var UserBioFeild: UILabel!
    
    var user: MyUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // make profile picture circular
        ProfilePictureImageView.layer.cornerRadius = ProfilePictureImageView.frame.size.width/2
        ProfilePictureImageView.clipsToBounds = true
        
        FirstNameFeild?.text = user?.firstName
        LastNameFeild?.text = user?.lastName
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let photo = ProfilePictureImageView.image,
            let firstName = FirstNameFeild.text,
            let lastName = LastNameFeild.text,
            let uid = user?.uid{
            let email = user?.email
            user = MyUser.init(firstName: firstName, lastName: lastName, email: email!, uid: uid)
        }
    }
    @IBAction func SelectedLeaderpressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
//    override func performSegue(withIdentifier identifier: String, sender: Any?) {
//      print("segue - \(identifier)")
//
//      if let destinationViewController = segue.destination as? OtherRideSearchViewController {
//          if let button = sender as? UIButton {
//                  secondViewController.<buttonIndex> = button.tag
//                  // Note: add/define var buttonIndex: Int = 0 in <YourDestinationViewController> and print there in viewDidLoad.
//          }
//
//        }
//    }
    
//    func transitionWhenDone(){
//        let destinationVC =
//        storyboard?.instantiateViewController(withIdentifier: "HostRideVC") as? HostRideViewController
//        view.window?.rootViewController = destinationVC
//        view.window?.makeKeyAndVisible()
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
