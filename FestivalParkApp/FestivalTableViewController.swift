//
//  FestivalTableViewController.swift
//  FestivalParkApp
//
//  Created by Ben Smith on 20/02/2017.
//  Copyright © 2017 Ben Smith. All rights reserved.
//

import UIKit
import Kingfisher
import SVProgressHUD

class FestivalTableViewController: UITableViewController {
    
    var festivalarray: [Festival] = []
    var currentFestival: Festival?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configure tableview custom properties
        configureTableView()
        SVProgressHUD.setBackgroundColor(UIColor.clear)
        SVProgressHUD.show()
        // title of the navigation bar and view in
        self.title = GlobalParams.main.title
    
        // Register to receive notification data
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(FestivalTableViewController.notifyObservers),
                                               name:  NSNotification.Name(rawValue: "gotFestivalsData" ),
                                               object: nil)

        DataProvider.sharedInstance.getFestivalsData()
        
        // sets the back button without title
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return festivalarray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        SVProgressHUD.dismiss()

        let cell = tableView.dequeueReusableCell(withIdentifier: "FestivalListTableViewCell", for: indexPath) as! FestivalListTableViewCell
        
        let festivalData = festivalarray[indexPath.row]
        cell.setDataForTableCell(festival: festivalData)
        
        return cell
        
    }
    
    func notifyObservers(notification: NSNotification) {
        var festivalsDictionary: Dictionary<String,[Festival]> = notification.userInfo as! Dictionary<String, [Festival]>
        festivalarray = festivalsDictionary["festivals"]!
        
        self.tableView.reloadData()
    }
    
 	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentFestival =  festivalarray[indexPath.row]
        self.performSegue(withIdentifier: "detailView", sender: self)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // returns from percentage extension -> Extensionfile
        return tableView.percentage(type: .height, with: 13) // 13%
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailView" {
            
            let detailView = segue.destination as! DetailsFestivalTableView
            detailView.theFestival = currentFestival
            
        }
        
    
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    func configureTableView() {
        // register nib cell
        let nib = UINib(nibName: "FestivalListTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "FestivalListTableViewCell")
        // change seperator color and inset between cells
        self.tableView.separatorColor = UIColor.gray
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)  
    }
 
}

