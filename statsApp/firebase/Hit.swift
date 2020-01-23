//
//  Hit.swift
//  statsApp
//
//  Created by Federico Lopez on 22/01/2020.
//  Copyright © 2020 Federico Lopez. All rights reserved.
//

import UIKit
import Firebase


class Hit {
    
    var uid: String = ""
    var year: Int = 0
    var month: Int = 0
    var day: Int = 0
    var item_uid: String = ""
    
    
    // MARK: Initialization
    init(item_uid: String, year: Int, month:  Int, day: Int) {
        // para crear nuevos hits de cero
        self.year = year
        self.month = month
        self.day = day
        self.item_uid = item_uid
    }
    
    init(uid: String, item_uid: String, data: [String: Any]) {
        // hits traidos desde la base de datos
        self.uid = uid
        self.year = data["year"] as! Int
        self.month = data["month"] as! Int
        self.day = data["day"] as! Int
        self.item_uid = item_uid
    }
    
    // MARK: misc
    private static func collection(item_uid: String) -> CollectionReference? {
        if let _uid = AppUser.current?.uid {
            let storeRef = Firestore.firestore()
            return storeRef.collection("users/" + _uid + "/items/" + item_uid + "/hits")
        } else {
            return nil
        }
    }
    
    // MARK: Actions
    func trace() {
        print("----------")
        print("HIT uid:", self.uid)
        print("HIT item uid:", self.item_uid)
        print("HIT fecha:", String(self.day) + "/" + String(self.month) + "/" + String(self.year))
    }
    
    
    func saveToServer(firstTime: Bool = false, callback: @escaping (Error?) -> () ) {
        let data = [
            "year": self.year,
            "month": self.month,
            "day": self.day
        ] as [String: Any]
        
        if let _collection = Hit.collection(item_uid: self.item_uid) {
            if(firstTime) {
                let newHit = _collection.document()
                newHit.setData(data) { (error) in
                    if(error == nil) {
                        self.uid = newHit.documentID
                    }
                    callback(error)
                }
            } else {
                _collection.document(self.uid).updateData(data) { (error) in
                    callback(error)
                }
            }
        }
    }
    
    
    
    
    
    
    
    
    /*
    
    
    
    
    
    static func getHits(itemUid: String, callback: @escaping ([Hit]?) -> ()) {
        if let _itemsCollection = Hit.collection() {
            _itemsCollection.getDocuments { (snapshot, error) in
                if(error == nil) {
                    var result: [Hit] = []
                    if let _docs = snapshot?.documents {
                        for d in _docs {
                            let newHit = Hit(uid: d.documentID, data: d.data())
                            result.append(newHit)
                        }
                    }
                    callback(result)
                } else {
                    callback(nil)
                }
            }
        }
    }
    */
    
}
