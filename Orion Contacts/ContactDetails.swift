//
//  ContactDetails.swift
//  Orion Contacts
//
//  Created by Dhiraj Jadhao on 04/06/16.
//  Copyright © 2016 Dhiraj Jadhao. All rights reserved.
//

import UIKit
import Eureka
import CoreLocation

class ContactDetails: FormViewController {

    //MARK:- Properties
    
    // This is the selected contact object from contact list
    var contactObject:Contact!

    //MARK:- View States
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initializeContactDetailForm(contactObject)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    //MARK:- Action Methods
    
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    //MARK:- Contact Detail Form Method
    
    func initializeContactDetailForm(contactObject:Contact) -> Void {
        
        self.title = contactObject.name
        
        form +++ Section("Contact")
            <<< TextFloatLabelRow(){ row  in
                row.title = "Name"
                row.value = contactObject.name
                row.disabled = true
                
                
        }
        
            <<< TextFloatLabelRow(){ row  in
                row.title = "Username"
                row.value = contactObject.username
                row.disabled = true
        }
        
            <<< TextFloatLabelRow(){ row  in
                row.title = "Phone"
                row.value = contactObject.phone
                row.disabled = true
        }
        
        
            <<< TextFloatLabelRow(){ row  in
                row.title = "Email"
                row.value = contactObject.email
                row.disabled = true
        }
        
        
        form +++ Section("Address")
            <<< TextFloatLabelRow(){ row  in
                row.title = "Street"
                row.value = contactObject.streetAddress
                row.disabled = true
        }
        
            <<< TextFloatLabelRow(){ row  in
                row.title = "Suite"
                row.value = contactObject.suiteAddress
                row.disabled = true
        }
        
            <<< TextFloatLabelRow(){ row  in
                row.title = "City"
                row.value = contactObject.city
                row.disabled = true
        }
            
            <<< TextFloatLabelRow(){ row  in
                row.title = "Zipcode"
                row.value = contactObject.zipcode
                row.disabled = true
        }
        
            <<< LocationRow(){ row in

                row.title = "Show On Map"
                row.value = CLLocation(latitude: (contactObject.lattitude as NSString).doubleValue, longitude: (contactObject.longitude as NSString).doubleValue)
        }
        
        
        
        form +++ Section("Website")
            <<< TextRow(){ row  in
                row.value = contactObject.website
                row.disabled = true
        }
        
        
        form +++ Section("Company")
            <<< TextFloatLabelRow(){ row  in
                row.title = "Name"
                row.value = contactObject.companyName
                row.disabled = true
        }
        
            <<< TextFloatLabelRow(){ row  in
                row.title = "Tagline"
                row.value = contactObject.companyCatchPhrase
                row.disabled = true
        }
        
            <<< TextFloatLabelRow(){ row  in
                row.title = "Status"
                row.value = contactObject.companyBusinessStatus
                row.disabled = true
        }
        
        
        
    }


}
    
