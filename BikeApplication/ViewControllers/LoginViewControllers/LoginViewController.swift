//
//  LoginViewController.swift
//  BikeApplication
//
//  Created by Sam Perry on 17/02/2020.
//  Copyright © 2020 Sam Perry. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var EmailFeild: UITextField!
    
    @IBOutlet weak var PasswordFeild: UITextField!
    @IBOutlet weak var LoginBtn: UIButton!
    @IBOutlet weak var ErrorMsg: UILabel!
    @IBOutlet weak var LoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frontEndSetUp()
    }
    
    func frontEndSetUp(){
        ErrorMsg.alpha = 0
        Utilities.styleTextField(EmailFeild)
        Utilities.styleTextField(PasswordFeild)
        Utilities.styleFilledButton(LoginButton)
    }

    @IBAction func LoginButtonTapped(_ sender: Any) {
        // validate feilds still to impliment
            //if all feilds valid do below
            let email = EmailFeild.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = PasswordFeild.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // sign in user
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if error != nil{
                    // sign in error
                    self.ErrorMsg.text = error!.localizedDescription
                    self.ErrorMsg.alpha = 1
                }else{
                    // go to home screen
                    self.transitionHome()
                }
            }
    }
    
    func transitionHome(){
     // need to set TabView as inital VC, then Show home page
        let tabViewController =
        storyboard?.instantiateViewController(withIdentifier: Constants.Storyboards.tabController) as? MainTabBarController
        view.window?.rootViewController = tabViewController
        view.window?.makeKeyAndVisible()
    }
}
