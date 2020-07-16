//
//  AuthService.swift
//  chatApp
//
//  Created by 舘佳紀 on 2020/07/16.
//  Copyright © 2020 Yoshiki Tachi. All rights reserved.
//

import Firebase
import UIKit

struct RegistrationCredentials {
    let email : String
    let password : String
    let fullname : String
    let username : String
    let profileImage : UIImage
}



struct AuthService {
    static let shared = AuthService()
    
    
    func logUserIn(withEmail email: String, password: String, complecation: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: complecation)
    }
    
    
    
    
    func createUser(credentials: RegistrationCredentials, complecation: ( (Error?) -> Void )? ) {
        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else { return }
               
               let firename = NSUUID().uuidString
               let ref = Storage.storage().reference(withPath: "profile_images/\(firename)")
               
               ref.putData(imageData, metadata: nil) { (meta, error) in
                   if let error = error {
                    complecation!(error)
                       return
                   }
                ref.downloadURL { ( url, error ) in
                    guard let profileImageUrl = url?.absoluteString else { return }
                       
                       
                    Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
                           
                           if let error = error {
                               complecation!(error)
                               return
                           }
                           
                           guard let uid = result?.user.uid else { return }
                           
                        let data = ["email": credentials.email,
                                    "fullname": credentials.fullname,
                                    "profileImageUrl": profileImageUrl,
                                       "uid": uid,
                                       "username": credentials.username] as [String : Any]
                        
                        Firestore.firestore().collection("users").document(uid).setData(data, completion: complecation)
                        
                    }
                }
        }
    }
}
