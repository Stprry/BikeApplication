//
//  ReigsterViewController.swift
//  BikeApplication
//
//  Created by Sam Perry on 17/02/2020.
//  Copyright © 2020 Sam Perry. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ReigsterViewController: UIViewController {

    @IBOutlet weak var FirstNameFeild: UITextField!
    
    @IBOutlet weak var SurnameFeild: UITextField!
    
    @IBOutlet weak var EmailFeild: UITextField!
    
    @IBOutlet weak var PasswordFeild: UITextField!
    
    @IBOutlet weak var RegisterBtn: UIButton!
    
    @IBOutlet weak var ErrorMsg: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        frontEndSetUp()
    }
    func frontEndSetUp(){
        ErrorMsg.alpha = 0
        Utilities.styleTextField(FirstNameFeild)
        Utilities.styleTextField(SurnameFeild)
        Utilities.styleTextField(EmailFeild)
        Utilities.styleTextField(PasswordFeild)
        Utilities.styleFilledButton(RegisterBtn)
    }

    
    // check and validate feilds if failed validation return error string
    func feildValidate() -> String?{
        
        // check feilds are filled
         if    FirstNameFeild.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
               SurnameFeild.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
               EmailFeild.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
               PasswordFeild.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
         {
                   return "Please fill in all fields."
         }
        // email validation maybe?
        
        
        // check Secure password with regEx utility method
        
        let uncheckedPass = PasswordFeild.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(uncheckedPass) == false {
            return "Please makes sure your Password is secure by using atleast 8 characters, a special character (!,-,=,.) and a number (0-9) "
        }
        
        return nil
    }
    @IBAction func RegisterTap(_ sender: Any) {
        
        //feild validation
        let error = feildValidate()
        
        if error != nil {
            // Error occured with feilds
            showError(error!)
        }else{
            // create clean data
            let firstName = FirstNameFeild.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = SurnameFeild.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = EmailFeild.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = PasswordFeild.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            // if no errors create user
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                ///CHANGE UID ID TO EQUAL DOC ID
                //error check
                if  err != nil{
                    self.showError("error creating user")
                }else{
                    //user sucsessfuly created, storing first and last name
                    let db = Firestore.firestore()

                    db.collection("users").addDocument(data: ["firstName":firstName,"lastName":lastName,"uid":result!.user.uid,"email":email]) { (error) in
                        if error != nil{
                            // error in database show error
                            self.showError("Something went wrong on our servers, First name or last name had something wrong")
                        }
                    }
                  let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                        changeRequest?.displayName = firstName + " " + lastName
                        changeRequest?.commitChanges { (error) in
                          // ...
                        }
                    // go to homescreen
                    self.transitionHome()
                    
                }
            }
        }
    }
    
    func showError(_ message:String){
        ErrorMsg.text = message
        ErrorMsg.alpha = 1
    }
    
    func transitionHome(){
             let tabViewController =
           storyboard?.instantiateViewController(withIdentifier: Constants.Storyboards.tabController) as? MainTabBarController
           view.window?.rootViewController = tabViewController
           view.window?.makeKeyAndVisible()

    }
}
