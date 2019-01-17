//
//  FeedVC.swift
//  BitGram
//
//  Created by Sohel Dhengre on 15/01/19.
//  Copyright © 2019 Sohel Dhengre. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class FeedVC: UICollectionViewController {

    
    // MARK: - Properties
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        //Configure Logout Button
        configureLogoutButton()
    }

    

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }


    //MARK: - Handlers
    
    func configureLogoutButton(){
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    }
    
    @objc func handleLogout(){
        
        //Declare Alert Controller
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            
            do {
                //Attempting Sign Out
                try Auth.auth().signOut()
                
                //Presenting Login VC
                let logInVC = LoginVC()
                let navController = UINavigationController(rootViewController: logInVC)
                self.present(navController, animated: true, completion: nil)
                
            } catch {
                print("Failed to logout user")
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}
