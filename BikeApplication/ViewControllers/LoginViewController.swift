//
//  LoginViewController.swift
//  BikeApplication
//
//  Created by Sam Perry on 17/02/2020.
//  Copyright © 2020 Sam Perry. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var EmailFeild: UITextField!
    
    @IBOutlet weak var PasswordFeild: UITextField!
    
    
    @IBOutlet weak var LoginBtn: UIButton!
    
    @IBOutlet weak var ErrorMsg: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        frontEndSetUp()
    }
    
    func frontEndSetUp(){
        ErrorMsg.alpha = 0
        Utilities.styleTextField(EmailFeild)
        Utilities.styleTextField(PasswordFeild)
        Utilities.styleHollowButton(LoginBtn)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func LoginTap(_ sender: Any) {
        
    }
    
}
