//
//  MemeTableViewCell.swift
//  memeMe2
//
//  Created by Kyle Stokes on 3/4/18.
//  Copyright © 2018 Kyle Stokes. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
