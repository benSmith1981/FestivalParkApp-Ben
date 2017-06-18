//
//  RouteTocCell.swift
//  FestivalParkApp
//
//  Created by Ivo  Nederlof on 02-03-17.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import UIKit

class RouteToCell: UITableViewCell {

    @IBOutlet var goToLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureCell()
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
         configureCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureCell() {
        self.backgroundColor = GlobalParams.navigation.barTintColor
        
    }
}
