//
//  UsersTableViewController.swift
//  SoftUni-L8
//
//  Created by Martin Kuvandzhiev on 13.10.21.
//

import UIKit
import RealmSwift

class UsersTableViewController: UITableViewController {
    
    var users: [User] = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(forName: .userDataLoaded, object: nil, queue: nil) { [weak self] _ in
            self?.loadData()
             self?.tableView.reloadData()
         }
        self.loadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    func loadData() {
        self.users.removeAll()
        DispatchQueue.main.async {
            let filteredUsers = LocalDataManager.realm.objects(User.self)
                .filter({ user in
                    return user.height > 2
                })
                .sorted(by: { $0.firstName > $1.firstName })
            
            self.users.append(contentsOf: filteredUsers)
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = self.users[indexPath.row].id
        cell.detailTextLabel?.text = "\(self.users[indexPath.row].firstName) \(self.users[indexPath.row].lastName)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(self.users[indexPath.row])
        let currentObject = self.users[indexPath.row]
        
        DispatchQueue.main.async {
            try? LocalDataManager.realm.write({
                currentObject.firstName = "Something"
            })
        }
    }

}
