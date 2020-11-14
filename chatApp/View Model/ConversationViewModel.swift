//
//  ConversationViewModel.swift
//  chatApp
//
//  Created by 舘佳紀 on 2020/11/14.
//  Copyright © 2020 Yoshiki Tachi. All rights reserved.
//

import Foundation

struct ConversationViewModel {
    
    private let conversation : Conversation
    
    var profileImageUrl : URL? {
        return URL(string: conversation.user.profileImageurl)
    }
    
    var timestamp : String {
        let date = conversation.message.timeStamp.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
    
    init(conversation: Conversation) {
        self.conversation = conversation
    }
}
