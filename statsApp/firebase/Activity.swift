//
//  Item.swift
//  statsApp
//
//  Created by Federico Lopez on 22/01/2020.
//  Copyright © 2020 Federico Lopez. All rights reserved.
//

import UIKit
import Firebase

class Activity {
    
    var uid: String = ""
    var name: String = ""
    
    var hits: [Hit] = []
    
    
    // MARK: Initialization
    init(name: String) {
        // para crear nuevas actividades de cero
        self.name = name
    }
    
    init(uid: String, data: [String: Any]) {
        // actividades traidas desde la base de datos
        self.uid = uid
        self.name = data["name"] as! String
    }
    
    // MARK: misc
    private static func collection() -> CollectionReference? {
        if let _uid = AppUser.current?.uid {
            let storeRef = Firestore.firestore()
            return storeRef.collection("users/" + _uid + "/activities")
        } else {
            return nil
        }
    }
    
    // MARK: Actions
    func trace() {
        TRACE("ACTIVITY")
        TRACE("uid: " + self.uid)
        TRACE("name: " + self.name)
    }
    
    func saveToServer(firstTime: Bool = false, callback: @escaping (Error?) -> () ) {
        let data = [
            "name": self.name
        ] as [String: Any]

        if let _collection = Activity.collection() {
            if(firstTime) {
                let newItem = _collection.document()
                newItem.setData(data) { (error) in
                    if(error == nil) {
                        self.uid = newItem.documentID
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
    
    static func getAll(callback: @escaping ([Activity]?) -> ()) {
        if let _collection = Activity.collection() {
            _collection.getDocuments { (snapshot, error) in
                if(error == nil) {
                    var result: [Activity] = []
                    if let _docs = snapshot?.documents {
                        for d in _docs {
                            let newItem = Activity(uid: d.documentID, data: d.data())
                            result.append(newItem)
                        }
                    }
                    callback(result)
                } else {
                    callback(nil)
                }
            }
        }
    }
    
    func delete(callback: @escaping (Error?) -> ()) {
        if let _collection = Activity.collection() {
            _collection.document(self.uid).delete { (error) in
                callback(error)
            }
        }
    }
    
    // MARK: Hits
    func loadAllHits(callback: @escaping () -> ()) {
        self.hits = []
        
        if let _collection = Activity.collection()?.document(self.uid).collection("hits") {
            _collection.getDocuments { (snapshot, error) in
                if(error == nil) {
                    if let _docs = snapshot?.documents {
                        for d in _docs {
                            let newHit = Hit(uid: d.documentID, item_uid: self.uid, data: d.data())
                            self.hits.append(newHit)
                        }
                        callback()
                    }
                } else {
                    callback()
                }
            }
        }
    }
    
    // MARK: Stats
    func getHitsCountPer(year: Int, month: Int? = nil) -> Int {
        if let _month = month {
            return self.hits.filter({$0.year==year && $0.month==_month}).count
        } else {
            return self.hits.filter({$0.year==year}).count
        }
    }
    
    func getValidYears() -> [Int] {
        let years = self.hits.map({ $0.year })
        return Array(Set(years).sorted())
    }
    
}
