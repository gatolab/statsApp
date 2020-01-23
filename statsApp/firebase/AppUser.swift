//
//  AppUser.swift
//  statsApp
//
//  Created by Federico Lopez on 22/01/2020.
//  Copyright © 2020 Federico Lopez. All rights reserved.
//

import UIKit
import Firebase


class AppUser: NSObject {
    
    static var current: User?
    
    static func registerUserWith(email: String, password: String, callback: @escaping (Int?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if(error == nil){
                AppUser.current = result?.user
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
                AppUser.current = result?.user
                callback(nil)
            }
            else {
                callback(ERROR_CODE(error))
            }
        }
    }
    
    static func recoverLogin() -> Bool {
        if let _user = Auth.auth().currentUser {
            AppUser.current = _user
            return true
        } else {
            return false
        }
    }
    
    static func logout(callback: (Bool) -> ()) {
        do {
            try Auth.auth().signOut()
            AppUser.current = nil
            callback(true)
        } catch {
            callback(false)
        }
    }
    
}

extension User {
    func trace() {
        print("----------")
        print("USER uid:", self.uid)
        print("USER email:", self.email!)
    }
}
