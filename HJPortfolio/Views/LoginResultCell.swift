//
//  LoginResultCell.swift
//  HJPortfolio
//
//  Created by 김희중 on 2020/09/04.
//  Copyright © 2020 HJ. All rights reserved.
//

import UIKit

class LoginResultCell: UICollectionViewCell {
    
    var delegate: LoginController?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Login Results"
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        return label
    }()
    
    let loginNameLabel: UILabel = {
        let label = UILabel()
        label.text = "SNS: "
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        return label
    }()
    
    let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Not connected"
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .red
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name:  "
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email:  "
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var titleLabelConstraint: NSLayoutConstraint?
    var statusLabelConstraint: NSLayoutConstraint?
    var loginNameLabelConstraint: NSLayoutConstraint?
    var nameLabelConstraint: NSLayoutConstraint?
    var emailLabelConstraint: NSLayoutConstraint?
    
    fileprivate func setupLayouts() {
        backgroundColor = .white
        
        addSubview(titleLabel)
        addSubview(statusLabel)
        addSubview(loginNameLabel)
        addSubview(nameLabel)
        addSubview(emailLabel)

        titleLabelConstraint = titleLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 30).first
        statusLabelConstraint = statusLabel.anchor(self.topAnchor, left: titleLabel.rightAnchor, bottom: nil, right: self.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 20, widthConstant: 0, heightConstant: 30).first
        loginNameLabelConstraint = loginNameLabel.anchor(titleLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30).first
        nameLabelConstraint = nameLabel.anchor(loginNameLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30).first
        emailLabelConstraint = emailLabel.anchor(nameLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30).first
        
        checkLogin()
        
    }
    
    fileprivate func checkLogin() {
//        delegate?.checkLogin()
    }
}
