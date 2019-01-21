//
//  Extensions.swift
//  BitGram
//
//  Created by SD on 11/01/19.
//  Copyright © 2019 Sohel Dhengre. All rights reserved.
//

import UIKit

extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}

var imageCache = [String:UIImage]()

extension UIImageView {
    
    func loadImage(with urlString:String){
        
        //Check if image exists in cache
        if let cachedImage = imageCache[urlString] {
            self.image = cachedImage
            return
        }
        
        //If image does not exists in cache
        
        
        //URL for image location
        guard let url = URL(string: urlString) else {return}
        
        //Fetch contents of URL
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            //Handle Error
            if let error = error {
                print("Failed: ", error.localizedDescription)
            }
            
            //Image Data
            guard let imageData = data else {return}
            
            //create image using image Data
            let photoImage = UIImage(data: imageData)
            
            //Set key and value of image cache
            imageCache[url.absoluteString] = photoImage
            
            //Set image
            DispatchQueue.main.async {
                self.image = photoImage
            }
        }.resume()
        
        
    }
    
}
