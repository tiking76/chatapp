//
//  User.swift
//  chatApp
//
//  Created by 舘佳紀 on 2020/07/17.
//  Copyright © 2020 Yoshiki Tachi. All rights reserved.
//

import Foundation

struct User {
    let uid : String
    let profileImageurl : String
    let username : String
    let fullname : String
    let email : String
    
    init(dictionary: [ String: Any ]) {
        self.uid = dictionary["uid"] as? String ?? ""
        self.profileImageurl = dictionary["profileImageUrl"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
    }
}
