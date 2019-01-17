//
//  LoginVC.swift
//  BitGram
//
//  Created by SD on 11/01/19.
//  Copyright © 2019 Sohel Dhengre. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    let logoContainerView: UIView = {
        let view = UIView()
        let logoImageView = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
        view.addSubview(logoImageView)
        logoImageView.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200 , height: 50)
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        view.backgroundColor = UIColor(displayP3Red: 0/255, green: 120/255, blue: 175/255, alpha: 1)
        return view
    }()

    let emailTextField: UITextField = {
       let tf = UITextField()
        tf.placeholder = "Email"
        tf.borderStyle = .roundedRect
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.borderStyle = .roundedRect
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    let dontHaveAnAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor(displayP3Red: 0/255, green: 120/255, blue: 175/255, alpha: 1) ]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(dontHaveAnAccountPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Hide Navigation Bar
        self.navigationController?.navigationBar.isHidden = true
        
        //background Color
        view.backgroundColor = .white
        view.addSubview(logoContainerView)
        logoContainerView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 150)
        configureViewComponents()
        view.addSubview(dontHaveAnAccountButton)
        dontHaveAnAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 0, width: 0, height: 50)
        
    }
    
    func configureViewComponents(){
        //StackView
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField,loginButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        view.addSubview(stackView)
        stackView.anchor(top: logoContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 40, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 140)
    }
    
    @objc func handleLogin(){
        
        //Grabbing email and password and logging user in
        guard let email = emailTextField.text,
            let password = passwordTextField.text else {return}
        
        //Firebase login
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            //handling error
            if let error = error {
                print("Failed: ", error.localizedDescription)
                return
            }
            
            //Handle success
            print("Success")
            
            guard let mainTabVC = UIApplication.shared.keyWindow?.rootViewController as? MainTabVC else {return}
            // Configure tab bar controller
            mainTabVC.configureViewControllers()
            
            //Dismiss Login View Controller
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func formValidation(){
        
        //Ensures that email and password textfields has text
        guard emailTextField.hasText,
            passwordTextField.hasText else {
                loginButton.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
                loginButton.isEnabled = false
                return
            }
        
        loginButton.isEnabled = true
        loginButton.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
    }
    
    @objc func dontHaveAnAccountPressed(){
        //Go to SignUp VC
        let vc = SignUpVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
