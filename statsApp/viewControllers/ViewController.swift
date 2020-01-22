//
//  ViewController.swift
//  statsApp
//
//  Created by Federico Lopez on 21/01/2020.
//  Copyright © 2020 Federico Lopez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        login()
        //logout()
        //createUser()
    }
    
    
    // MARK: Some actions
    func createUser() {
        let email = "gatolab@gmail.com"
        let pass = "gato123"
        
        FirebaseUtils.registerUserWith(email: email, password: pass) { (errorCode) in
            if(errorCode==nil) {
                print("User created succesfully!")
            } else {
                var error = "Unknown error"
                switch errorCode {
                    case 17007:
                        error = "The email belongs to an existing account"
                    default:
                        print("")
                }
                
                print(error)
            }
        }
    }
    
    func login() {
        let email = "gatolab@gmail.com"
        let pass = "gato123"
        
        FirebaseUtils.loginWith(email: email, password: pass) { (errorCode) in
            if(errorCode==nil) {
                print("Login succes!")
                self.traceUser()
            } else {
                var error = "Unknown error"
                switch errorCode {
                    case 17011:
                        error = "Non-existent email"
                    case 17009:
                        error = "Wrong credentials"
                    default:
                        print("")
                }
                
                print(error)
            }
        }
    }
    
    func logout() {
        FirebaseUtils.logout { (success) in
            print("Logout:", success)
        }
    }
    
    func traceUser() {
        if let _user = FirebaseUtils.currentUser {
            print(_user.uid)
            print(_user.email)
        }
    }


}

