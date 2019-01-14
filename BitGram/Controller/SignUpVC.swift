//
//  SignUpVC.swift
//  BitGram
//
//  Created by SD on 13/01/19.
//  Copyright © 2019 Sohel Dhengre. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var imageSelected: Bool = false
    let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleSelectProfilePhoto), for: .touchUpInside)
        return button
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
        tf.isSecureTextEntry = true
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    
    let fullNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Full Name"
        tf.borderStyle = .roundedRect
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    
    let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.borderStyle = .roundedRect
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return tf
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.isEnabled = false
        button.addTarget(self, action: #selector(signUpPressed), for: .touchUpInside)
        return button
    }()
    
    let logInButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: "Sign In", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor(displayP3Red: 0/255, green: 120/255, blue: 175/255, alpha: 1) ]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(signInPressed), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //View Background Color
        view.backgroundColor = .white
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 50, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
        plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        configureViewComponents()
        
        view.addSubview(logInButton)
        logInButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 12, paddingRight: 0, width: 0, height: 50)
    }
    
    func configureViewComponents(){
        //StackView
        let stackView = UIStackView(arrangedSubviews: [emailTextField, fullNameTextField, usernameTextField, passwordTextField, signUpButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        view.addSubview(stackView)
        stackView.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 240)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            imageSelected = false
            return
        }
        imageSelected = true
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.height/2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.black.cgColor
        plusPhotoButton.layer.borderWidth = 2
        plusPhotoButton.setImage(pickedImage.withRenderingMode(.alwaysOriginal) , for: .normal)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleSelectProfilePhoto() {
        
        //Configure Image Picker
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        //Present image picker
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func signUpPressed() {
        
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let fullName = fullNameTextField.text else {return}
        guard let userName = usernameTextField.text else{return}
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Failed: ", error.localizedDescription)
            }
            
            //Set profile Image
            guard let profileImage = self.plusPhotoButton.imageView?.image else {return}
            //Upload Data
            guard let uploadData = profileImage.jpegData(compressionQuality: 0.3) else {return}
            // Place image in Firebase Storage
            let fileName = UUID().uuidString
            let storageRef = Storage.storage().reference().child("profile_image").child(fileName)
            storageRef.putData(uploadData, metadata: nil, completion: { (metaData, error) in
                
                // handle error
                if let error = error {
                    print("Failed to upload image to Firebase Storage with error", error.localizedDescription)
                    return
                }
                
                storageRef.downloadURL(completion: { (downloadUrl, error) in
                    guard let profileImageURL = downloadUrl?.absoluteString else {
                        print("Failed: ")
                        return }
                    
                    //user id
                    guard let uid = result?.user.uid else {return}
                    
                    // Save user info to database
                    let dictionaryValues = ["name": fullName,
                                            "user":userName,
                                            "profileImageURl": profileImageURL]
                    let values = [uid:dictionaryValues]
                    Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (error, ref) in
                        print("Success")
                    })
                })
                
                
            })
            
        }
    }
    
    @objc func signInPressed() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @objc func formValidation() {
        
        guard  emailTextField.hasText ,
               passwordTextField.hasText,
               usernameTextField.hasText,
               fullNameTextField.hasText,
               imageSelected == true else {
                    
                signUpButton.isEnabled = false
                signUpButton.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
                    return
        }
        
        signUpButton.isEnabled = true
        signUpButton.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
    }
    

}
