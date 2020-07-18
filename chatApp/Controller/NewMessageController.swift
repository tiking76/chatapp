//
//  NewMessageController.swift
//  chatApp
//
//  Created by 舘佳紀 on 2020/07/16.
//  Copyright © 2020 Yoshiki Tachi. All rights reserved.
//

import UIKit

private let reuseIdentifier = "UserCell"

protocol NewMessageCnotrollerDelegate : class {
    func controller(_ controller: NewMessageController, wantsToStartChatWith user: User)
}
   

class NewMessageController: UITableViewController {
    
    private var users = [User]()
    weak var delegate: NewMessageCnotrollerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        featchUsers()
    }
    
    
    @objc func habdleDismissal() {
        dismiss(animated: true, completion: nil)
    
    }
    
    func featchUsers() {
        Service.fetchUsers { users in
            self.users = users
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    func configureUI() {
        configureNavigationBar(withTitle: "New Message", prefersLargeTitle: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(habdleDismissal))
        
        tableView.tableFooterView = UIView()
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 80
    }
}

extension NewMessageController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("DEBUG: User count is \(users.count)")
        return users.count
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        cell.user = users[indexPath.row]
        return cell
    }
}

//要チェック
extension NewMessageController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("DEBUG: Selected user is \(users[indexPath.row].username)")
        delegate?.controller(self, wantsToStartChatWith: users[indexPath.row])
    }
}

