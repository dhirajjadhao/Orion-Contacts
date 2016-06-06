//
//  ContactsList.swift
//  Orion Contacts
//
//  Created by Dhiraj Jadhao on 04/06/16.
//  Copyright © 2016 Dhiraj Jadhao. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
import ObjectMapper
import SVProgressHUD



class ContactsList: UIViewController, UISearchControllerDelegate {

    //MARK:- Properties
    
    @IBOutlet var contactTableView: UITableView!
    @IBOutlet var sortButton: UIButton!
    
    let searchController = UISearchController(searchResultsController: nil)
    let realm = try! Realm()
  
    
    @IBOutlet var statusImageView: UIImageView!
    @IBOutlet var statusLabel: UILabel!
    
    var sortingAscending:Bool = true
    var contactSearchResults : Results = try! Realm().objects(Contact).sorted("name", ascending: true)
    var contactResults : Results = try! Realm().objects(Contact).sorted("name", ascending: true)
    
    
    
    //MARK:- View States
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "AvenirNext-Bold", size: 20)!, NSForegroundColorAttributeName: appThemeColor]

        
        try! self.realm.write {
            self.realm.deleteAll()
        }
        
        
        
        if isInternetAvailable(){
            
            SVProgressHUD.showWithStatus("Fetching Contacts...")
            self.fetchContactsFromServer()
            
        }
        else{
            
            statusImageView.image = UIImage(named: "no-internet")
            statusLabel.text = "No Internet Available!"
            contactTableView.hidden = true

        }
        
        
        sortButton.addTarget(self, action:#selector (self.toggleSort), forControlEvents: UIControlEvents.TouchUpInside)
        
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.searchBarStyle = UISearchBarStyle.Minimal
        self.contactTableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.tintColor = appThemeColor
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "contactDetails" {
         
            var contactObject:Contact!
            
            if searchController.active  {
                
                contactObject = contactSearchResults[(contactTableView.indexPathForSelectedRow?.row)!]
                
            }
            else{
                
                contactObject = contactResults[(contactTableView.indexPathForSelectedRow?.row)!]
            }

            let destination:ContactDetails = segue.destinationViewController as! ContactDetails
            destination.contactObject = contactObject
            
        }
    }
    
    
    
    //MARK:- Networking Methods
    
    func fetchContactsFromServer() -> Void {
        
        Alamofire.request(.GET, "http://jsonplaceholder.typicode.com/users", parameters: nil)
            .validate()
            .responseJSON { response in
                
                switch response.result {
                case .Success:
                    
                    if let JSON = response.result.value {
                        
                        for i in 0..<JSON.count{
                         
                            let contact = Mapper<Contact>().map(JSON[i])
                            
                            try! self.realm.write {
                                self.realm.add(contact!, update: true)
                            }
                            
                        }
                        
                        self.contactTableView.reloadData()
                        SVProgressHUD.dismiss()
                    }
                    
                case .Failure(let error):
                    print(error)
                }
        }
    }
    
    //MARK:- Sorting Method

    func toggleSort() -> Void {
        
        if sortingAscending {
            
            contactResults = try! Realm().objects(Contact).sorted("name", ascending: false)
            self.sortButton.setImage(UIImage(named: "sort-a-to-z"), forState: UIControlState.Normal)
            self.contactTableView.reloadData()
            sortingAscending = false
        }
        else{
            
            contactResults = try! Realm().objects(Contact).sorted("name", ascending: true)
            self.sortButton.setImage(UIImage(named: "sort-z-to-a"), forState: UIControlState.Normal)
            self.contactTableView.reloadData()
            sortingAscending = true
        }
        
    }
    
    //MARK:- Table View Delegate Methods
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.active {
            
            if contactSearchResults.count == 0 {
                contactTableView.hidden = true
                
                statusImageView.image = UIImage(named: "contacs-icon")
                statusLabel.text = "No Result Found?"
            }
            else{
                
                contactTableView.hidden = false
            }

            
            return contactSearchResults.count
            
        }
        else{
            if contactResults.count == 0 {
                contactTableView.hidden = true
                
            }
            else{
                
                contactTableView.hidden = false
            }
            return contactResults.count
        }
        
    }
    
    
    
    
     func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    
    
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:ContactCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ContactCell
        
        var contactObject:Contact

        
        if searchController.active  {
            
            contactObject = contactSearchResults[indexPath.row]
            
        }
        else{
            
            contactObject = contactResults[indexPath.row]
        }
   
        
        
            cell.contactName.text = contactObject.name
            cell.contactEmail.text = contactObject.email
            cell.phoneNumber = contactObject.phone
            cell.backgroundColor = cellBGColor
            
            if UIDevice.currentDevice().userInterfaceIdiom == .Pad{
                
                cell.callButton.hidden = true
            }
            else{
                cell.callButton.hidden = false
            }
            
            return cell
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
          self.contactTableView.reloadData()
    }
    
    
    
    //MARK:- Search Methods
    
    func filterContentForSearchText(searchText: String, scope: String = "All"){
        
        let predicate = NSPredicate(format: "name CONTAINS [c] %@ OR username CONTAINS [c] %@ OR email CONTAINS [c] %@ OR city CONTAINS [c] %@ OR phone CONTAINS [c] %@ OR website CONTAINS [c] %@ OR companyName CONTAINS [c] %@", searchText, searchText, searchText, searchText, searchText, searchText, searchText)
        
        contactSearchResults = contactResults.filter(predicate)
        self.contactTableView.reloadData()
    }

}






extension ContactsList: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}



    //MARK:- Device Type Declaration

enum UIUserInterfaceIdiom : Int {
    case Unspecified
    
    case Phone // iPhone and iPod touch style UI
    case Pad // iPad style UI
}



