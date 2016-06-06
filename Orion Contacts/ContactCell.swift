//
//  ContactCell.swift
//  Orion Contacts
//
//  Created by Dhiraj Jadhao on 04/06/16.
//  Copyright © 2016 Dhiraj Jadhao. All rights reserved.
//

import UIKit
import SVProgressHUD


class ContactCell: UITableViewCell {
    
    //MARK:- Properties
    
    @IBOutlet var contactName: UILabel!
    @IBOutlet var contactEmail: UILabel!
    @IBOutlet var callButton: UIButton!
    var phoneNumber:NSString!
    

    //MARK:- View States
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    //MARK:- Action Methods
    
    @IBAction func callButtonPressed(sender: AnyObject) {
        
         placeCall(phoneNumber)

    }
    
    
    
    
    
    //MARK:- Phone Service Method
    
    func placeCall(phoneNumber:NSString) -> Void{
        
        var phoneCallURL:NSURL?
        
        phoneCallURL =  NSURL(string: "tel://\(phoneNumber)")
        
        if phoneCallURL != nil {
            
            UIApplication.sharedApplication().openURL(phoneCallURL!)
        }
        else{
            
            print("Invalid Phone Number!")
            SVProgressHUD.showErrorWithStatus("Invalid Phone Number!")
        }
        
    }
    
    
}



