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

        if(AppUser.recoverLogin()) {
            getAllHits()
        }
    }
    
    
    // MARK: Hits
    func addHit() {
        let newHit = Hit(item_uid: "xvgwc0qo1Supf7z3AWkg", year: 2015, month: 12, day: 5)
        newHit.saveToServer(firstTime: true) { (error) in
            if(error==nil){ print("hit creado!") }
        }
    }
    
    func getAllHits() {
        Item.getAll { (items) in
            if let _items = items {
                if let item = _items.first {
                    
                    item.trace()
                    item.loadAllHits {
                        for h in item.hits {
                            h.trace()
                        }
                    }
                    
                }
            }
        }
    }
    
    // MARK: Items
    func createItem() {
        let newItem = Item(name: "Caro Fioramonti")
        newItem.saveToServer(firstTime: true) { (error) in
            if(error==nil){ print("item creado!") }
        }
    }
    
    func getAllItems() {
        Item.getAll { (items) in
            if let _items = items {
                for i in _items {
                    i.trace()
                }
            }
        }
    }
    
    // MARK: Users
    func createUser() {
        let email = "gatolab@gmail.com"
        let pass = "gato123"
        
        AppUser.registerUserWith(email: email, password: pass) { (errorCode) in
            if(errorCode==nil) {
                print("User created succesfully!")
                AppUser.current?.trace()
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
        
        AppUser.loginWith(email: email, password: pass) { (errorCode) in
            if(errorCode==nil) {
                print("Login succes!")
                AppUser.current?.trace()
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
        AppUser.logout { (success) in
            print("Logout:", success)
        }
    }


}

