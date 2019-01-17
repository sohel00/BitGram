//
//  MainTabVC.swift
//  BitGram
//
//  Created by Sohel Dhengre on 15/01/19.
//  Copyright © 2019 Sohel Dhengre. All rights reserved.
//

import UIKit
import Firebase

class MainTabVC: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Delegate
        self.delegate = self
        
        //Configure View Controllers
        configureViewControllers()
        
        //User Validation
        checkUserLoggedIn()
    }
    

    //Function to create view controllers that exist in this tab bar
    func configureViewControllers(){
        
        //home feed controller
        let feedVC = constructNavController(selectedImage: #imageLiteral(resourceName: "home_selected"), unSelectedImage: #imageLiteral(resourceName: "home_unselected"), rootViewController: FeedVC(collectionViewLayout: UICollectionViewFlowLayout()))
        
        //search feed controller
        let searchVC = constructNavController(selectedImage: #imageLiteral(resourceName: "search_selected"), unSelectedImage: #imageLiteral(resourceName: "search_unselected"), rootViewController: SearchVC())
        
        //post controller
        let uploadPostVC = constructNavController(selectedImage: #imageLiteral(resourceName: "plus_unselected"), unSelectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: SearchVC())
        
        //notification controller
        let notificationVC = constructNavController(selectedImage: #imageLiteral(resourceName: "like_selected"), unSelectedImage: #imageLiteral(resourceName: "like_unselected"), rootViewController: NotificationsVC())
        
        //profile controller
        let userProfileVC = constructNavController(selectedImage: #imageLiteral(resourceName: "profile_selected"), unSelectedImage: #imageLiteral(resourceName: "profile_unselected"), rootViewController: UserProfileVC(collectionViewLayout: UICollectionViewFlowLayout()))
        
        //View controllers to be added to tab bar controller
        viewControllers = [feedVC, searchVC, uploadPostVC, notificationVC, userProfileVC]
        
        //tab bar tint color
        tabBar.tintColor = .black
        
    }
    
    //Construct navigation controller
    func constructNavController(selectedImage:UIImage, unSelectedImage:UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        
        //Construct nav controller
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.image = unSelectedImage
        navController.tabBarItem.selectedImage = selectedImage
        navController.navigationBar.tintColor = .black
        
        return navController
    }
    
    func checkUserLoggedIn(){
        
        if Auth.auth().currentUser == nil {
            //Presenting Login VC
            DispatchQueue.main.async {
                let logInVC = LoginVC()
                let navController = UINavigationController(rootViewController: logInVC)
                self.present(navController, animated: true, completion: nil)
            }
        }
        return
    }
    

}
