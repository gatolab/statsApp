//
//  ItemCell.swift
//  statsApp
//
//  Created by Federico Lopez on 23/01/2020.
//  Copyright © 2020 Federico Lopez. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var imgImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(_ item: Item) {
        self.nameLabel.text = item.name
    }
}
