//
//  SearchUserCell.swift
//  BitGram
//
//  Created by Sohel Dhengre on 21/01/19.
//  Copyright © 2019 Sohel Dhengre. All rights reserved.
//

import UIKit

class SearchUserCell: UITableViewCell {

    //Mark: Properties
    let profileIamgeView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        //Add profile image
        addSubview(profileIamgeView)
        profileIamgeView.anchor(top: nil, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 48, height: 48)
        profileIamgeView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileIamgeView.layer.cornerRadius = 24
        profileIamgeView.clipsToBounds = true
        
        self.textLabel?.text = "User Name"
        self.detailTextLabel?.text = "Full Name"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 68, y: (textLabel?.frame.origin.y)! - 2, width: (textLabel?.frame.width)!, height: (textLabel?.frame.height)!)
        textLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        
        detailTextLabel?.frame = CGRect(x: 68, y: (detailTextLabel?.frame.origin.y)!, width: self.frame.width - 108, height: (detailTextLabel?.frame.height)!)
        detailTextLabel?.textColor = .lightGray
        detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
