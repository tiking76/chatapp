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
    
    init(conversation: Conversation) {
        self.conversation = conversation
    }
}
