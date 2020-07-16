//
//  NewMessageController.swift
//  chatApp
//
//  Created by 舘佳紀 on 2020/07/16.
//  Copyright © 2020 Yoshiki Tachi. All rights reserved.
//

import UIKit


class NewMessageController: UITableViewController {
    
    private let reuseIdentifier = "UserCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    @objc func habdleDismissal() {
        dismiss(animated: true, completion: nil)
    
    }
    
    
    
    func configureUI() {
        configureNavigationBar(withTitle: "New Message", prefersLargeTitle: false)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(habdleDismissal))
        
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 80
    }
}

extension NewMessageController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = "Test Label"
        return cell
    }
}

