//
//  Service.swift
//  chatApp
//
//  Created by 舘佳紀 on 2020/07/17.
//  Copyright © 2020 Yoshiki Tachi. All rights reserved.
//

import Firebase

struct Service {
    
    static func fetchUsers(complecation: @escaping ([User]) -> Void) {
        var users = [User]()
        Firestore.firestore().collection("users").getDocuments { snapshot, error in
            snapshot?.documents.forEach({ document in
                
                
                let dictionary = document.data()
                let user = User(dictionary: dictionary)
                
                users.append(user)
                complecation(users)
            })
        }
    }
}
