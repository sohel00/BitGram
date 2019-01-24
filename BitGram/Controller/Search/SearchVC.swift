//
//  SearchVC.swift
//  BitGram
//
//  Created by Sohel Dhengre on 15/01/19.
//  Copyright © 2019 Sohel Dhengre. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "SearchUserCell"

class SearchVC: UITableViewController {
    
    //MARK: Properties
    
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(SearchUserCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        //TableView separator inset
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 64, bottom: 0, right: 0)
        
        //Configure Navigation Controller
        configureNavController()
        
        //Fetch Users
        fetchUsers()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchUserCell
        cell.user = self.users[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let user = users[indexPath.row]
        
        //Create instance of userProfileVC
        let userProfileVC = UserProfileVC(collectionViewLayout: UICollectionViewFlowLayout())
        
        userProfileVC.userToLoadFromSearchVC = user
        
        //Pushing userProfileViewController
        navigationController?.pushViewController(userProfileVC, animated: true)
    }
    
    //MARK: Handlers
    
    func configureNavController(){
        navigationItem.title = "Explore"
    }
    
    //Mark: API
    
    func fetchUsers(){
        
        Database.database().reference().child("users").observe(.childAdded) { snapshot in
            
            //User UID
            let uid = snapshot.key
        
            //Snapshot value casted as dictionary
            guard let dictionary = snapshot.value as? Dictionary<String, AnyObject> else {return}
            
            let user = User(uid: uid, dictionary: dictionary)
            
            //Appending data to dataSource
            self.users.append(user)
            
            //Reloading tableview
            self.tableView.reloadData()
            
            
        }
        
    }


}
