//
//  ItemCell.swift
//  statsApp
//
//  Created by Federico Lopez on 23/01/2020.
//  Copyright © 2020 Federico Lopez. All rights reserved.
//

import UIKit
import SDWebImage


class ActivityCell: UITableViewCell {

    @IBOutlet weak var actImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setData(_ item: Activity) {
        self.actImageView.image = nil
        if let _image = SDImageCache.shared().imageFromCache(forKey: item.imageURL) {
            self.actImageView.image = _image
            self.actImageView.setCircular()
        }
        
        self.nameLabel.text = item.name
    }
}
