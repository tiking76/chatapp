//
//  RegistrationViewModel.swift
//  chatApp
//
//  Created by 舘佳紀 on 2020/07/14.
//  Copyright © 2020 Yoshiki Tachi. All rights reserved.
//

import Foundation

struct RegistrationViewModel : AuthenticationProtocol{
    
    var email : String?
    var fullName : String?
    var userName : String?
    var passwprd : String?
    
    var formIsVaild : Bool {
        return email?.isEmpty == false
            && fullName?.isEmpty == false
            && userName?.isEmpty == false
            && passwprd?.isEmpty == false
    }
}
