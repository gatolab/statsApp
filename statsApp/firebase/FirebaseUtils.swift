//
//  FirebaseUtils.swift
//  statsApp
//
//  Created by Federico Lopez on 22/01/2020.
//  Copyright © 2020 Federico Lopez. All rights reserved.
//

import UIKit
import Firebase


class FirebaseUtils: NSObject {
    
    // MARK: User
    static var currentUser: User?
    
    static func registerUserWith(email: String, password: String, callback: @escaping (Int?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if(error == nil){
                FirebaseUtils.currentUser = result?.user
                callback(nil)
            }
            else {
                callback(ERROR_CODE(error))
            }
        }
    }
    
    static func loginWith(email: String, password: String, callback: @escaping (Int?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if(error == nil){
                FirebaseUtils.currentUser = result?.user
                callback(nil)
            }
            else {
                callback(ERROR_CODE(error))
            }
        }
    }
    
    static func logout(callback: (Bool) -> ()) {
        do {
            try Auth.auth().signOut()
            callback(true)
        } catch {
            callback(false)
        }
    }
    
}
