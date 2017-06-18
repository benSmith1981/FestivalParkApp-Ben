//
//  DetailmageSliderCell.swift
//  FestivalParkApp
//
//  Created by Ivo  Nederlof on 27-02-17.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import UIKit

class DetailmageSliderCell: UITableViewCell,
                            UICollectionViewDataSource,
                            UICollectionViewDelegate,
                            UICollectionViewDelegateFlowLayout {

    @IBOutlet var collectionView: UICollectionView!
    
    var testdata = ["he","llo"]
    
    var festival:Festival?
    
    /// TODO: GET INT SETTINGS PARAMETERS
    let itemsPerRow: CGFloat = 1
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 20.0, right: 10.0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // setup collection view
        configureCollectionView()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCollectionView() {
        //register
        let featuredCell = UINib(nibName: "ImageSliderCollectionViewCell", bundle: nil)
        collectionView.register(featuredCell, forCellWithReuseIdentifier: "imageCellID")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }

}
