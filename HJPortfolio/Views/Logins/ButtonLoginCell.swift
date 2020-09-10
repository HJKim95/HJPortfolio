//
//  buttonLoginCell.swift
//  HJPortfolio
//
//  Created by 김희중 on 2020/09/04.
//  Copyright © 2020 HJ. All rights reserved.
//

import UIKit

class ButtonLoginCell: UICollectionViewCell {
    
    var delegate: LoginController?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Login Buttons"
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        return label
    }()
    
    lazy var kakaoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "kakao")
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(loginKakao)))
        iv.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 50).isActive = true
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        return iv
    }()
    
    lazy var naverImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "naver")
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(loginNaver)))
        iv.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 50).isActive = true
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        return iv
    }()
    
    lazy var facebookImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "facebook")
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(loginFacebook)))
        iv.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 50).isActive = true
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        return iv
    }()
    
    lazy var appleImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "apple")
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(loginApple)))
        iv.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 50).isActive = true
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let buttonStackView: UIStackView = {
        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.horizontal
        stackView.distribution  = .equalSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var titleLabelConstraint: NSLayoutConstraint?
    var buttonStackViewConstraint: NSLayoutConstraint?
    
    fileprivate func setupLayouts() {
        backgroundColor = .white

        buttonStackView.addArrangedSubview(kakaoImageView)
        buttonStackView.addArrangedSubview(naverImageView)
        buttonStackView.addArrangedSubview(facebookImageView)
        buttonStackView.addArrangedSubview(appleImageView)

        addSubview(titleLabel)
        addSubview(buttonStackView)
        
        titleLabelConstraint = titleLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30).first
        buttonStackViewConstraint = buttonStackView.anchor(titleLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 30, leftConstant: 30, bottomConstant: 0, rightConstant: 30, widthConstant: 0, heightConstant: 50).first
    }
    
    @objc func loginKakao() {
        delegate?.loginKakao()
    }
    
    @objc func loginNaver() {
        delegate?.loginNaver()
    }
    
    @objc func loginFacebook() {
        delegate?.loginFacebook()
    }
    
    @objc func loginApple() {
        delegate?.loginApple()
    }
}
