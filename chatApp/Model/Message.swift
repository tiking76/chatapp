//
//  Message.swift
//  chatApp
//
//  Created by 舘佳紀 on 2020/07/20.
//  Copyright © 2020 Yoshiki Tachi. All rights reserved.
//

import Firebase

struct Message {
    let text: String
    let toId : String
    let fromId : String
    var timeStamp: Timestamp!
    var user: User?
    
    let isFromCurrentUser : Bool
    
    init(dictinary: [String: Any]) {
        self.text = dictinary["text"] as? String ?? ""
        self.toId = dictinary["toId"] as? String ?? ""
        self.fromId = dictinary["fromId"] as? String ?? ""
        self.timeStamp = dictinary["timestamp"] as? Timestamp ?? Timestamp.init(date: Date())
        
        self.isFromCurrentUser = fromId == Auth.auth().currentUser?.uid
    }
}
