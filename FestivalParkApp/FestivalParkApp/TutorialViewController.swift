//
//  TutorialViewController.swift
//  FestivalParkApp
//
//  Created by Maya Lekova on 3/1/17.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.view.backgroundColor = GlobalParams.navigation.barTintColr
        // Do any additional setup after loading the view.
    }

    
    @IBAction func dismissTutorial(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
