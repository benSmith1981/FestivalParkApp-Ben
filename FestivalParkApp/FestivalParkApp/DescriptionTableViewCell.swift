//
//  DescriptionTableViewCell.swift
//  FestivalParkApp
//
//  Created by Christophe Delaporte on 02/03/2017.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var DescriptionTextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
