//
//  appUser.swift
//  statsApp
//
//  Created by Federico Lopez on 21/01/2020.
//  Copyright © 2020 Federico Lopez. All rights reserved.
//

import UIKit
import Firebase


class appUser {
    
    func registerWith(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if(error != nil) {
                let errorCode = ERROR_CODE(error)
                
                switch errorCode {
                    case 17007:
                        print("The email belongs to an existing account")
                    default:
                        print("Unknown error")
                }
            }
        }
    }

}
