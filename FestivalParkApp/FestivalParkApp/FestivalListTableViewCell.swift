//
//  FestivalListTableViewCell.swift
//  FestivalParkApp
//
//  Created by Jeroen de Bie on 24/02/2017.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import UIKit
import Kingfisher

class FestivalListTableViewCell: UITableViewCell {

    @IBOutlet weak var mediaView: UIImageView!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var dateView: UILabel!
    @IBOutlet weak var extraInfoView: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
         configureMediaView()

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layoutIfNeeded()
        configureMediaView()
 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
        // Display text/media in cell.
    
    func setDataForTableCell(festival: Festival) {
        self.titleView.text = festival.title
        
        let (startDate, endDate) = (festival.dates?.getDatesSpan())!
        let combinedDate = startDate + "  |  " + endDate
        self.dateView.text = combinedDate
        
        self.extraInfoView.text = festival.location?.adress

        let url = URL(string: festival.getMainMedia())
        self.mediaView.kf.setImage(with: url)
    }
    
    func configureMediaView() {

        mediaView.layer.masksToBounds = true
        mediaView.clipsToBounds = true
        mediaView.layer.cornerRadius = mediaView.frame.height/2
        
    }
}
