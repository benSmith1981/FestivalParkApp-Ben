//
//  MainNavigationController.swift
//  FestivalParkApp
//
//  Created by Ivo  Nederlof on 28-02-17.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        customNavigationBar()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    
    func customNavigationBar() {

    
        navigationBar.barTintColor = GlobalParams.navigation.barTintColor
        navigationBar.titleTextAttributes = [
            NSFontAttributeName: UIFont(name: "SFShaiFontai-Bold", size: 32)!,
            NSForegroundColorAttributeName : UIColor.white]
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationBar.clipsToBounds = false
    }

}
