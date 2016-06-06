//
//  OrionContactsDataModel.swift
//  Orion Contacts
//
//  Created by Dhiraj Jadhao on 03/06/16.
//  Copyright © 2016 Dhiraj Jadhao. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper


class Contact: Object, Mappable {
    
    dynamic var id = Int()
    dynamic var name = ""
    dynamic var username = ""
    dynamic var email = ""
    dynamic var streetAddress = ""
    dynamic var suiteAddress = ""
    dynamic var city = ""
    dynamic var zipcode = ""
    dynamic var lattitude = ""
    dynamic var longitude = ""
    dynamic var phone = ""
    dynamic var website = ""
    dynamic var companyName = ""
    dynamic var companyCatchPhrase = ""
    dynamic var companyBusinessStatus = ""
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    
    required convenience init?(_ map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        username <- map["username"]
        email <- map["email"]
        streetAddress <- map["address.street"]
        suiteAddress <- map["address.suite"]
        city <- map["address.city"]
        zipcode <- map["address.zipcode"]
        lattitude <- map["address.geo.lat"]
        longitude <- map["address.geo.lng"]
        phone <- map["phone"]
        website <- map["website"]
        companyName <- map["company.name"]
        companyCatchPhrase <- map["company.catchPhrase"]
        companyBusinessStatus <- map["company.bs"]
    }
    
}



