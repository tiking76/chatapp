//
//  MessgeViewModel.swift
//  chatApp
//
//  Created by 舘佳紀 on 2020/07/20.
//  Copyright © 2020 Yoshiki Tachi. All rights reserved.
//

import UIKit

struct MessageViewModel {
    
    private let message : Message
    
    var messageBackgroundColor : UIColor {
        return message.isFromCurrentUser ? #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) : .systemPurple
    }
    
    
    var messageTextColor : UIColor {
        return message.isFromCurrentUser ? .black : .white
    }
    
    //相手と自分
    var rightAnchorActive: Bool {
        return message.isFromCurrentUser
    }
    
    var leftAnchorActive: Bool {
        return !message.isFromCurrentUser
    }
    
    var shouldHideProfileImage: Bool {
        return message.isFromCurrentUser
    }
    
    init(message: Message) {
        self.message = message
    }
}

