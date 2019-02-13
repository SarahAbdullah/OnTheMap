//
//  TableViewCell.swift
//  On the Map
//
//  Created by Sarah on 1/11/19.
//  Copyright © 2019 Sarah. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var URL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
}
