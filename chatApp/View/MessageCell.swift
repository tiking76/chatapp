//
//  MessageCell.swift
//  chatApp
//
//  Created by 舘佳紀 on 2020/07/18.
//  Copyright © 2020 Yoshiki Tachi. All rights reserved.
//

import UIKit

class MessageCell : UICollectionViewCell {
    
    var message: Message? {
        didSet { configure() }
    }
    
    var bubbleLeftAnchor: NSLayoutConstraint!
    var bubbleRightAnchor: NSLayoutConstraint!
    
    private let profileImageView : UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .lightGray
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()

    private let textView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = .clear
        tv.font = UIFont.systemFont(ofSize: 16)
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.textColor = .white
        return tv
    }()
    
    private let bubbleContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPurple
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileImageView)
        profileImageView.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 8,paddingBottom: -4)
        profileImageView.setDimensions(width: 32, height: 32)
        profileImageView.layer.cornerRadius = 32 / 2
        
        addSubview(bubbleContainer)
        bubbleContainer.layer.cornerRadius = 12
        bubbleContainer.anchor(top: topAnchor)
        bubbleContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        
        bubbleLeftAnchor = bubbleContainer.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12)
        
        bubbleLeftAnchor.isActive = false
        bubbleRightAnchor = bubbleContainer.rightAnchor.constraint(equalTo: rightAnchor, constant: -12)
        bubbleRightAnchor.isActive = false
        
        bubbleContainer.addSubview(textView)
        textView.anchor(top: bubbleContainer.topAnchor, left: bubbleContainer.leftAnchor, bottom: bubbleContainer.bottomAnchor, right: bubbleContainer.rightAnchor, paddingTop: 4, paddingLeft: 12, paddingBottom: 4, paddingRight: 12)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        guard let message = message else { return }
        let viewModel = MessageViewModel(message: message)
        
        bubbleContainer.backgroundColor = viewModel.messageBackgroundColor
        textView.textColor = viewModel.messageTextColor
        textView.text = message.text
        
        bubbleLeftAnchor.isActive = viewModel.leftAnchorActive
        bubbleRightAnchor.isActive = viewModel.rightAnchorActive
    }
    
}
