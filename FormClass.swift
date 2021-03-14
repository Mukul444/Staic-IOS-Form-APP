//
//  FormClass.swift
//  Form_App
//
//  Created by webwerks1 on 05/02/21.
//  Copyright © 2021 webwerks. All rights reserved.
//

import Foundation

class Form   {
    var uid : String?
    var  name : String = ""
    var  surname : String = ""
    var  gender : String = ""
    var  educationStatus : String = ""
    var  phoneNo : Int = 0
    var  emailId : String = ""
    
    init()
    {

    }
    
    
    init(name : String, surname : String,gender : String,educationStatus : String,phoneNo: Int,emailId : String) {
        self.name = name
        self.surname = surname
        self.gender = gender
        self.educationStatus = educationStatus
        self.phoneNo = phoneNo
        self.emailId = emailId
        
    }
    
    func formDetails() {
        print("Name: \(name) Surname: \(surname) \n gender: \(gender)\n EducatonalStatus: \(educationStatus)\n PhoneNumber: \(phoneNo)\n EmailId:\(emailId)")
    }
}
