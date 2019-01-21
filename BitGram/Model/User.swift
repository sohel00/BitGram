//
//  User.swift
//  BitGram
//
//  Created by Sohel Dhengre on 20/01/19.
//  Copyright © 2019 Sohel Dhengre. All rights reserved.
//

class User {
    
    //Attributes
    var userName:String!
    var name:String!
    var profileImageURL:String!
    var uid:String!
    
    init(uid:String, dictionary: Dictionary<String, AnyObject>){
        
        self.uid = uid
        
        if let userName = dictionary["user"] as? String{
            self.userName = userName
        }
        
        if let name = dictionary["name"] as? String{
            self.name = name
        }
        
        if let profileImageURL = dictionary["profileImageURl"] as? String{
            self.profileImageURL = profileImageURL
        }
    }
}
