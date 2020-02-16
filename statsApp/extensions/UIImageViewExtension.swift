//
//  UIImageViewExtension.swift
//  statsApp
//
//  Created by Federico Lopez on 15/02/2020.
//  Copyright © 2020 Federico Lopez. All rights reserved.
//

import UIKit

extension UIImageView {
    func setCircular() {
        self.layer.cornerRadius = self.frame.width/2
        
        /*
        self.layer.borderWidth = 1.5
        let alpha: CGFloat = 0.06
        let borderColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: alpha)
        self.layer.borderColor = borderColor.cgColor
        */
    }
}
