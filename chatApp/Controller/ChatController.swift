//
//  ChatController.swift
//  chatApp
//
//  Created by 舘佳紀 on 2020/07/18.
//  Copyright © 2020 Yoshiki Tachi. All rights reserved.
//

import UIKit

private let reuseIdentifer = "Message Call"

class ChatController: UICollectionViewController {
    
    private let user : User
    
    
    private lazy var  customInputView : CustomInputAccessoryView = {
        let iv = CustomInputAccessoryView(frame: CGRect(x: 0, y: 0, width:view.frame.width , height: 50))
        return iv
    }()
    
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        print("DEBUG: User in chat controller is \(user.username)")
    }
    
    override var inputAccessoryView: UIView? {
        get { return customInputView}
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    
    func configureUI() {
        collectionView.backgroundColor = .white
        configureNavigationBar(withTitle: user.username, prefersLargeTitle: false)
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: reuseIdentifer)
        collectionView.alwaysBounceVertical = true
    }
}

extension ChatController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifer, for: indexPath) as! MessageCell
        return cell
    }
}

extension ChatController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 50)
    }
}
