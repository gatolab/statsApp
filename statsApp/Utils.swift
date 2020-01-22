//
//  Utils.swift
//  statsApp
//
//  Created by Federico Lopez on 21/01/2020.
//  Copyright © 2020 Federico Lopez. All rights reserved.
//

import UIKit

func ERROR_CODE(_ error: Error?) -> Int {
    var result = 0
    if let E = error as NSError? {
        result = E.code
        print(">>> ERROR", E.code, E.description)
    }
    
    return result
}
