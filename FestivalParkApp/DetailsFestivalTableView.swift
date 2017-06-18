//
//  DetailsFestivalTableView.swift
//  
//
//  Created by Christophe Delaporte on 24/02/2017.
//
//

import UIKit
import Kingfisher

class DetailsFestivalTableView: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextViewDelegate {
    
    var theFestival: Festival?
    var currentFestival: Festival?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let imageCollectionNib = UINib(nibName: "DetailmageSliderCell", bundle: nil)
        tableView.register(imageCollectionNib, forCellReuseIdentifier: "detailImageCellID")
        
        let descriptionTableViewNib = UINib(nibName: "DescriptionTableViewCell", bundle:  nil)
        self.tableView.register(descriptionTableViewNib, forCellReuseIdentifier: "descriptionTableViewCell")
        
        let addressTableViewNib = UINib(nibName: "AddressTableViewCell", bundle: nil)
        self.tableView.register(addressTableViewNib, forCellReuseIdentifier: "addressTableViewCell")
        
        let titleTableViewNib = UINib(nibName: "TitleViewCell", bundle: nil)
        self.tableView.register(titleTableViewNib, forCellReuseIdentifier: "titleViewCellID")
        
        let routeToCell = UINib(nibName: "RouteToCell", bundle: nil)
        self.tableView.register(routeToCell, forCellReuseIdentifier: "RouteToCellID")

        
        let cameraButton = UIBarButtonItem.init(barButtonSystemItem: .camera, target: self, action: #selector(DetailsFestivalTableView.takePicture(_:)))
        let sharingButton = UIBarButtonItem.init(barButtonSystemItem: .action, target: self, action: #selector(DetailsFestivalTableView.shareFestival))
        self.navigationItem.rightBarButtonItems = [cameraButton, sharingButton]
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // sets the back button without title
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

 // height for the indexpath per type of cell
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        self.tableView.estimatedRowHeight = 2
        
        switch indexPath.row {
        case DetailType.imageCollection.PositionsAsInteger():
             return view.percentage(type: .height, with: 40)
            
        case DetailType.name.PositionsAsInteger():
            return view.percentage(type: .height, with: 6)
            
        case DetailType.description.PositionsAsInteger():
            return UITableViewAutomaticDimension
       
            
        case DetailType.address.PositionsAsInteger():
            return UITableViewAutomaticDimension
         
            
        case DetailType.routeTo.PositionsAsInteger():
            return view.percentage(type: .height, with: 8)
            
        default:
            return 0

        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        switch indexPath.row {
            
        case DetailType.imageCollection.PositionsAsInteger():
            let imageCell = tableView.dequeueReusableCell(withIdentifier: "detailImageCellID", for: indexPath)  as! DetailmageSliderCell
            imageCell.awakeFromNib()
            imageCell.festival = theFestival
            imageCell.separatorInset.left = view.frame.width
            
            return imageCell
            
        case DetailType.name.PositionsAsInteger():
            let titleCell = tableView.dequeueReusableCell(withIdentifier: "titleViewCellID", for: indexPath) as! TitleViewCell
            
            titleCell.titleLabel?.text = theFestival?.title?.uppercased()
            titleCell.separatorInset.left = view.frame.width
            
            return titleCell
            
        case DetailType.description.PositionsAsInteger():
            let descriptionCell = tableView.dequeueReusableCell(withIdentifier: "descriptionTableViewCell", for: indexPath) as! DescriptionTableViewCell
            
            // test expanding cells
            descriptionCell.DescriptionTextView.delegate = self
            
            //test encode html
            let text = theFestival?.details?.en?.longdescription?.stringByDecodingHTMLEntities
            let str = text?.replacingOccurrences(of: "<[^]>]+>", with: "", options: .regularExpression, range: nil)
            
            descriptionCell.DescriptionTextView.text = str
            
            return descriptionCell
            
        case DetailType.address.PositionsAsInteger():
            let addressCell = tableView.dequeueReusableCell(withIdentifier: "addressTableViewCell", for: indexPath) as!
            AddressTableViewCell
            
            addressCell.AddressTextView.delegate = self
            if let address = theFestival?.location?.adress,
                let zip = theFestival?.location?.zipcode,
                let city = theFestival?.location?.city {
            let addressText = "\(address)\n\(zip)\n \(city)"

                addressCell.AddressTextView.text = addressText
            }
            
            return addressCell
            
        default:
            
            let routeCell = tableView.dequeueReusableCell(withIdentifier: "RouteToCellID", for: indexPath) as! RouteToCell
            routeCell.awakeFromNib()
            
            if let title = theFestival?.title {
            routeCell.goToLabel.text = "Route to \(title)"
                
            }
            
            return routeCell
        }
    }
    
    func takePicture(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.delegate = self
        
        present(imagePicker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        let title: String = theFestival?.title ?? "Festival in Amsterdam"
        let description: String = theFestival?.details?.en?.shortdescription ?? ""
        
        let activityViewController = UIActivityViewController(activityItems: [title, description, image], applicationActivities: nil)
        activityViewController.excludedActivityTypes = [UIActivityType.assignToContact]
        activityViewController.completionWithItemsHandler = {
            (activityType, completed, returnedItems, activityError) in
            self.dismiss(animated: true, completion: nil)
        }
        picker.present(activityViewController, animated: true)
    }
    
    func shareFestival(_ sender: UIBarButtonItem) {
        let title: String = theFestival?.title ?? "Festival in Amsterdam"
        let description: String = theFestival?.details?.en?.shortdescription ?? ""
        let (firstDate, endDate) = theFestival?.dates?.getDatesSpan() ?? ("", "")

        let text = "Join me for the \(title)!\n" +
            "From \(firstDate) till \(endDate) and here's some info:" +
            "\n\n" + description
        let activityViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        self.present(activityViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toRouteView", sender: self)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        switch indexPath.row {
        case 0...3:
            return nil
        default:
            return indexPath
        }
    }
    
    
    // MARK: Segue
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRouteView" {
            
            let toRouteView = segue.destination as! RouteMapViewController
            toRouteView.selectedFestival = theFestival
            
        }
    }
    
//    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
//        code
//    }
}

