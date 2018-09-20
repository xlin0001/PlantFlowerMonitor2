//
//  RaspioEntryDetailTableViewCell.swift
//  Assignment2New
//
//  Created by Oliver Lin on 19/9/18.
//  Copyright © 2018 Monash University. All rights reserved.
//

import UIKit

class RaspioEntryDetailTableViewCell: UITableViewCell {

    
    @IBOutlet weak var attributeValueLabel: UILabel!
    @IBOutlet weak var attributeNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
