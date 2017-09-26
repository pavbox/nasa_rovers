//
//  RoverTableViewCell.swift
//  Rovers
//
//  Created by Admin on 25/09/2017.
//  Copyright © 2017 pavbox. All rights reserved.
//

import UIKit

class RoverTableViewCell: UITableViewCell {
    
    @IBOutlet weak var RoverTitle: UILabel!
    @IBOutlet weak var RoverLaunchDate: UILabel!
    @IBOutlet weak var RoverLastActiveDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
