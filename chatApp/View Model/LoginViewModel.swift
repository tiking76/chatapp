//
//  LoginViewModel.swift
//  chatApp
//
//  Created by 舘佳紀 on 2020/07/14.
//  Copyright © 2020 Yoshiki Tachi. All rights reserved.
//

import Foundation

protocol  AuthenticationProtocol {
    var formIsVaild: Bool { get }
}


struct LoginViewModel : AuthenticationProtocol {
    var email : String?
    var passwprd : String?
    var formIsVaild : Bool {
        return email?.isEmpty == false && passwprd?.isEmpty == false
    }
}
