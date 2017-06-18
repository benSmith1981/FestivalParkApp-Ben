//
//  MainTabBarController.swift
//  FestivalParkApp
//
//  Created by Ivo  Nederlof on 02-03-17.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Custom tints
        
        tabBar.barTintColor = UIColor.white
        tabBar.isTranslucent = false
        tabBar.tintColor = GlobalParams.navigation.barTintColor

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
