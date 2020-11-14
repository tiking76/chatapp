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
        COLLECTION_USER.getDocuments { snapshot, error in
            snapshot?.documents.forEach({ document in
                
                
                let dictionary = document.data()
                let user = User(dictionary: dictionary)
                
                users.append(user)
                complecation(users)
            })
        }
    }
    
    static func featchUser(withUid uid: String, complication: @escaping (User) -> Void) {
        COLLECTION_USER.document(uid).getDocument { (snapshot, error) in
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            complication(user)
        }
    }
    
    static func featchConversations(complication :  @escaping ([Conversation]) -> Void) {
        var conversations = [Conversation]()
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let query = COLLECTION_MESSAGES.document(uid).collection("recent-messages").order(by: "timestamp")
        
        query.addSnapshotListener { (snapshot, error) in
            snapshot?.documentChanges.forEach({ change in
                let dictionary = change.document.data()
                let message = Message(dictinary: dictionary)
                self.featchUser(withUid: message.toId) { user in
                    let conversation = Conversation(user: user, message: message)
                    conversations.append(conversation)
                    complication(conversations)
                }
            })
        }
    }
    
    
    static func featchMessages(forUser user: User, complication : @escaping ([Message]) -> Void) {
        var message  = [Message]()
        
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        let quary = COLLECTION_MESSAGES.document(currentUid).collection(user.uid).order(by: "timeatamp")
        
        quary.addSnapshotListener { (snapshot, error) in
            snapshot?.documentChanges.forEach({ change in
                if change.type == .added {
                    let dictionary = change.document.data()
                    message.append(Message(dictinary: dictionary))
                    complication(message)
                }
            })
        }
    }
    
    
    static func uploadMessage(_ message: String, to user: User, complication: ((Error?) -> Void)? ) {
    guard let currentUid = Auth.auth().currentUser?.uid else { return }
    
    //data dictionaly
    let data = ["text": message,
                "fromId": currentUid,
                "toId": user.uid,
                "timeatamp": Timestamp(date: Date())] as [String: Any]
    
    COLLECTION_MESSAGES.document(currentUid).collection(user.uid).addDocument(data: data) { _ in
        COLLECTION_MESSAGES.document(user.uid).collection(currentUid).addDocument(data: data, completion: complication)
        COLLECTION_MESSAGES.document(currentUid).collection("recent-messages").document(user.uid).setData(data)
        COLLECTION_MESSAGES.document(user.uid).collection("recent-messages").document(currentUid).setData(data)
    }
}
}
